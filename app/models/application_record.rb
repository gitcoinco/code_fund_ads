class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :search_column, ->(column_name, value) do
    where arel_table[column_name].lower.matches("%#{model.send :sanitize_sql_like, value.downcase}%")
  end
end
