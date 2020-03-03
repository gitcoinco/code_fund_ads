class ApplicationRecord < ActiveRecord::Base
  include GlobalID::Identification

  self.abstract_class = true
  connects_to database: {writing: :primary, reading: :primary_replica}
  delegate :local_ephemeral_cache, to: :Rails

  class << self
    delegate :local_ephemeral_cache, to: :Rails

    def sanitize_sql_value(value)
      sanitize_sql_array ["?", value]
    end

    def fully_quote_column_name(name, model: nil)
      model ||= self
      "#{model.quoted_table_name}.#{connection.quote_column_name name}"
    end

    def range_boundary(range)
      [range.first, range.last]
    end
  end

  delegate :sanitize_sql_value, to: "self.class"
  delegate :quoted_table_name, to: "self.class"
  delegate :quote_column_name, to: "self.class.connection"
  delegate :fully_quote_column_name, to: "self.class"

  scope :search_column, ->(column_name, value) do
    where arel_table[column_name].lower.matches("%#{model.send :sanitize_sql_like, value.downcase}%")
  end
end
