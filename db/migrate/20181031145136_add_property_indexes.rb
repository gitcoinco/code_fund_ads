# frozen_string_literal: true

class AddPropertyIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :properties, :legacy_id
    add_index :properties, "(lower(name))", name: "index_properties_on_name"
    add_index :properties, :property_type
    add_index :properties, :no_api_house_ads
    add_index :properties, :topic_categories, using: :gin
    add_index :properties, :programming_languages, using: :gin
    add_index :properties, :excluded_advertisers, using: :gin
  end
end
