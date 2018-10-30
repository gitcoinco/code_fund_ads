# frozen_string_literal: true

class AddCampaignIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :campaigns, "(lower(name))", name: "index_campaigns_on_name"
    add_index :campaigns, "(start_date::date)", name: "index_campaigns_on_start_date"
    add_index :campaigns, "(end_date::date)", name: "index_campaigns_on_end_date"
    add_index :campaigns, :status
    add_index :campaigns, :creative_id
    add_index :campaigns, :us_hours_only
    add_index :campaigns, :weekdays_only
    add_index :campaigns, :included_countries, using: :gin
    add_index :campaigns, :included_topic_categories, using: :gin
    add_index :campaigns, :included_programming_languages, using: :gin
    add_index :campaigns, :excluded_topic_categories, using: :gin
    add_index :campaigns, :excluded_programming_languages, using: :gin
  end
end
