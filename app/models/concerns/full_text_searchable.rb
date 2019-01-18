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
    after_commit :set_full_text_search, on: [:create, :update]

    scope :fts, ->(value) {
      prepared_value = value.to_s.gsub(/\W/, " ").squeeze(" ").downcase.strip
      return none if prepared_value.blank?
      select(Arel.star).
        select(sanitize_sql(["round(cast(ts_rank(#{quoted_table_name}.#{connection.quote_column_name :full_text_search}, plainto_tsquery('english', ?)) as numeric), 2) rank", prepared_value])).
        where("#{quoted_table_name}.#{connection.quote_column_name :full_text_search} @@ plainto_tsquery('english', ?)", prepared_value).
        order("rank desc")
    }
  end

  def set_full_text_search
    self.class.connection.execute <<~QUERY
      UPDATE #{self.class.quoted_table_name}
      SET #{self.class.connection.quote_column_name :full_text_search} = #{to_tsvector}
      WHERE #{self.class.connection.quote_column_name :id} = #{id}
    QUERY
  end

  # to_tsvector is abstract... a noop by default
  # it must be implemented in including ActiveRecord models if this behavior is desired
  def to_tsvector
    nil
  end

  protected

  def make_tsvector(value, weight: "D")
    "setweight(to_tsvector('english', '#{FullTextSearchable.fts_string(value)}'), '#{weight}')"
  end
end
