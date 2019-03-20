class AddCtaToCreatives < ActiveRecord::Migration[5.2]
  def change
    add_column :creatives, :cta, :string
  end
end
