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

  private

  def set_id
    self.id ||= ApplicationRecord.uuid
  end

  def set_inserted_at
    return unless respond_to?(:inserted_at=)
    self.inserted_at ||= Time.current
  end
end
