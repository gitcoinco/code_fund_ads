class AddFallbackAdTemplateAndThemeToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :fallback_ad_template, :string
    add_column :properties, :fallback_ad_theme, :string
  end
end
