# frozen_string_literal: true

module FullTextSearchable
  extend ActiveSupport::Concern

  module ClassMethods
    def ngrams(value, min: 2, max: 10)
      value = fts_string(value)
      [].tap do |result|
        (min..max).each do |num|
          result.concat value.scan(/\w{#{num}}/)
        end
      end.uniq
    end

    def fts_words(value)
      Loofah.fragment(value.to_s).scrub!(:whitewash).to_text.gsub(/\W/, " ").squeeze(" ").downcase.split
    end

    def fts_string(value)
      value = fts_words(value).join(" ")
      value = value.chop while value.bytes.size > 2046
      value
    end

    def make_tsvector(value, weight: "D")
      value = fts_string(value).gsub(/\W/, " ").squeeze(" ").downcase
      return nil if value.blank?
      sanitize_sql ["setweight(to_tsvector('simple', ?), ?)", value, weight]
    end
  end

  delegate :ngrams, :fts_words, :fts_string, :make_tsvector, to: "self.class"

  included do
    after_commit :update_full_text_search, on: [:create, :update]

    scope :matched, ->(value) {
      value = value.to_s.squeeze(" ").downcase.strip
      value.blank? ? all : begin
        value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", value]))
        websearch_to_tsquery = Arel::Nodes::NamedFunction.new("websearch_to_tsquery", [Arel::Nodes::SqlLiteral.new("'simple'"), value])
        where Arel::Nodes::InfixOperation.new("@@", arel_table[:full_text_search], websearch_to_tsquery)
      end
    }

    scope :ranked, ->(value) {
      rank_alias = "rank"
      value = value.to_s.squeeze(" ").downcase.strip
      value.blank? ? all : begin
        value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", value]))
        websearch_to_tsquery = Arel::Nodes::NamedFunction.new("websearch_to_tsquery", [Arel::Nodes::SqlLiteral.new("'simple'"), value])
        ts_rank = Arel::Nodes::NamedFunction.new("ts_rank", [arel_table[:full_text_search], websearch_to_tsquery])
        select(Arel.star)
          .select(ts_rank.as(rank_alias))
          .order("#{rank_alias} desc")
      end
    }

    scope :matched_and_ranked, ->(value) { value.blank? ? all : matched(value).ranked(value) }
  end

  def update_full_text_search
    tsvectors = to_tsvectors.compact.uniq
    return if tsvectors.blank?
    tsvectors.concat similarity_words_tsvectors
    tsvectors.pop while tsvectors.size > 500
    tsvector = tsvectors.join(" || ")

    self.class.connection.execute <<~QUERY
      UPDATE #{quoted_table_name}
      SET #{quote_column_name :full_text_search} = #{tsvector}
      WHERE #{quote_column_name :id} = #{id}
    QUERY
  end

  # to_tsvector is abstract... a noop by default
  # it must be implemented in including ActiveRecord models if this behavior is desired
  def to_tsvectors
    []
  end

  def similarity_words
    tsvectors = to_tsvectors.compact.uniq
    return [] if tsvectors.blank?
    tsvector = tsvectors.join(" || ")

    ts_stat = Arel::Nodes::NamedFunction.new("ts_stat", [
      Arel::Nodes::SqlLiteral.new(sanitize_sql_value("SELECT #{tsvector}"))
    ])
    length = Arel::Nodes::NamedFunction.new("length", [Arel::Nodes::SqlLiteral.new(quote_column_name(:word))])
    query = self.class.select(:word).from(ts_stat.to_sql).where(length.gteq(3)).to_sql
    result = self.class.connection.execute(query)
    result.values.flatten
  end

  def similarity_words_tsvectors(weight: "C")
    similarity_words.each_with_object([]) { |word, memo|
      ngrams(word, max: word.size).each { |ngram| memo << make_tsvector(ngram, weight: weight) }
    }.compact.uniq
  end
end
