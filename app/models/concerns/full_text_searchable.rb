# frozen_string_literal: true

module FullTextSearchable
  extend ActiveSupport::Concern

  class << self
    def fts_words(value)
      Loofah.fragment(value.to_s).scrub!(:whitewash).to_text.gsub(/\W/, " ").squeeze(" ").downcase.split
    end

    def fts_string(value)
      value = fts_words(value).join(" ")
      value = value.chop while value.bytes.size > 2046
      value
    end
  end

  included do
    has_many :words, as: :record, dependent: :destroy
    after_commit :set_full_text_search, on: [:create, :update]

    scope :similar, ->(value) {
      words = FullTextSearchable.fts_words(value)
      words.blank? ? none : begin
        relation = all
        words.each do |word|
          relation = relation.where(id: Word.where(record_type: name).similar(word).select(:record_id))
        end
        relation
      end
    }

    scope :ranked, ->(value) {
      value = value.to_s.gsub(/\W/, " ").squeeze(" ").downcase.strip
      return none if value.blank?
      value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", value]))
      plainto_tsquery = Arel::Nodes::NamedFunction.new("plainto_tsquery", [Arel::Nodes::SqlLiteral.new("'simple'"), value])
      ts_rank = Arel::Nodes::NamedFunction.new("ts_rank", [arel_table[:full_text_search], plainto_tsquery])
      select(Arel.star).
        select(ts_rank.as("rank")).
        order("rank desc")
    }

    scope :matching, ->(value) {
      value = value.to_s.gsub(/\W/, " ").squeeze(" ").downcase.strip
      return none if value.blank?
      value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", value]))
      plainto_tsquery = Arel::Nodes::NamedFunction.new("plainto_tsquery", [Arel::Nodes::SqlLiteral.new("'simple'"), value])
      where Arel::Nodes::InfixOperation.new("@@", arel_table[:full_text_search], plainto_tsquery)
    }
  end

  def similarity_words
    result = self.class.connection.execute("SELECT word from ts_stat('SELECT #{to_tsvector.gsub(/'/, "''")}')")
    result.values.flatten
  end

  def set_full_text_search
    self.class.connection.execute <<~QUERY
      UPDATE #{self.class.quoted_table_name}
      SET #{self.class.connection.quote_column_name :full_text_search} = #{to_tsvector}
      WHERE #{self.class.connection.quote_column_name :id} = #{id}
    QUERY

    Word.where(record_type: self.class.name, record_id: id).delete_all
    Word.bulk_insert(:record_type, :record_id, :word) do |worker|
      similarity_words.each do |word|
        worker.add [self.class.name, id, word]
      end
    end
  end

  # to_tsvector is abstract... a noop by default
  # it must be implemented in including ActiveRecord models if this behavior is desired
  def to_tsvector
    nil
  end

  protected

  def make_tsvector(value, weight: "D")
    self.class.sanitize_sql ["setweight(to_tsvector('simple', ?), '#{weight}')", FullTextSearchable.fts_string(value)]
  end
end
