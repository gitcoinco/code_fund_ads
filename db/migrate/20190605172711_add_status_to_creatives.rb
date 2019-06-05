class AddStatusToCreatives < ActiveRecord::Migration[5.2]
  def change
    add_column :creatives, :status, :string, default: ENUMS::CREATIVE_STATUSES::PENDING
  end
end
