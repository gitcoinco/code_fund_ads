# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :set_id
  before_create :set_inserted_at

  def self.uuid
    connection.exec_query("select gen_random_uuid() as uuid").first["uuid"]
  end

  def created_at
    inserted_at
  end

  def created_at=(value)
    self.inserted_at = value
  end

  scope :search_column, -> (column_name, value) do
    where arel_table[column_name].lower.matches("%#{model.send :sanitize_sql_like, value.downcase}%")
  end

  private

    def set_id
      self.id ||= ApplicationRecord.uuid
    end

    def set_inserted_at
      return unless respond_to?(:inserted_at=)
      self.inserted_at ||= Time.current
    end
end
