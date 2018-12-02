class RenameImpressionIp < ActiveRecord::Migration[5.2]
  def change
    rename_column :impressions, :ip, :ip_address
  end
end
