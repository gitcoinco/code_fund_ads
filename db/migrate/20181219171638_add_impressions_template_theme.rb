class AddImpressionsTemplateTheme < ActiveRecord::Migration[5.2]
  def up
    remove_column :impressions, :campaign_name
    remove_column :impressions, :property_name
    add_column :impressions, :ad_template, :string
    add_column :impressions, :ad_theme, :string
    add_index :impressions, :ad_template
    add_index :impressions, :ad_theme
  end

  def down
    remove_column :impressions, :ad_template
    remove_column :impressions, :ad_theme
    add_column :impressions, :campaign_name, :string
    add_column :impressions, :property_name, :string
    add_index :impressions, :campaign_name
    add_index :impressions, :property_name
  end
end
