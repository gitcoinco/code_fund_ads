# frozen_string_literal: true

class RemoveNotNullFromPropertiesFields < ActiveRecord::Migration[5.2]
  def change
    change_column :properties, :ad_template, :string, null: true
    change_column :properties, :ad_theme, :string, null: true
  end
end
