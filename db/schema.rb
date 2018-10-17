# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_10_203633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "assets", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name", limit: 255, null: false
    t.string "image_object", limit: 255, null: false
    t.string "image_bucket", limit: 255, null: false
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.integer "height"
    t.integer "width"
    t.index ["user_id"], name: "assets_user_id_index"
  end

  create_table "audiences", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "programming_languages", limit: 255, default: [], array: true
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.string "topic_categories", limit: 255, default: [], array: true
    t.uuid "fallback_campaign_id"
    t.index ["programming_languages"], name: "audiences_programming_languages_index"
  end

  create_table "campaigns", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "redirect_url", null: false
    t.integer "status", default: 0, null: false
    t.decimal "ecpm", precision: 10, scale: 2, null: false
    t.decimal "budget_daily_amount", precision: 10, scale: 2, null: false
    t.decimal "total_spend", precision: 10, scale: 2, null: false
    t.uuid "user_id"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "audience_id"
    t.uuid "creative_id"
    t.string "included_countries", limit: 255, default: [], array: true
    t.integer "impression_count", default: 0, null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "us_hours_only", default: false
    t.boolean "weekdays_only", default: false
    t.string "included_programming_languages", limit: 255, default: [], array: true
    t.string "included_topic_categories", limit: 255, default: [], array: true
    t.string "excluded_programming_languages", limit: 255, default: [], array: true
    t.string "excluded_topic_categories", limit: 255, default: [], array: true
    t.boolean "fallback_campaign", default: false, null: false
    t.index ["user_id"], name: "campaigns_user_id_index"
  end

  create_table "creatives", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name", limit: 255
    t.string "body", limit: 255
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.string "headline", limit: 255
    t.uuid "small_image_asset_id"
    t.uuid "large_image_asset_id"
    t.uuid "wide_image_asset_id"
    t.index ["user_id"], name: "creatives_user_id_index"
  end

  create_table "distributions", id: :uuid, default: nil, force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency", limit: 255, null: false
    t.datetime "range_start", null: false
    t.datetime "range_end", null: false
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions", id: :uuid, default: nil, force: :cascade do |t|
    t.string "ip", limit: 255, null: false
    t.text "user_agent"
    t.string "browser", limit: 255
    t.string "os", limit: 255
    t.string "device_type", limit: 255
    t.string "country", limit: 255
    t.string "region", limit: 255
    t.string "city", limit: 255
    t.string "postal_code", limit: 255
    t.decimal "latitude"
    t.decimal "longitude"
    t.uuid "property_id"
    t.uuid "campaign_id"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "redirected_at"
    t.string "redirected_to_url", limit: 255
    t.decimal "revenue_amount", precision: 13, scale: 12, default: "0.0", null: false
    t.decimal "distribution_amount", precision: 13, scale: 12, default: "0.0", null: false
    t.uuid "distribution_id"
    t.integer "browser_height"
    t.integer "browser_width"
    t.integer "error_code"
    t.boolean "house_ad", default: false
    t.index "((inserted_at)::date)", name: "index_impressions_on_inserted_at_date"
    t.index ["campaign_id"], name: "impressions_campaign_id_index"
    t.index ["ip"], name: "impressions_ip_index"
    t.index ["property_id"], name: "impressions_property_id_index"
  end

  create_table "invitations", id: :uuid, default: nil, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "token", limit: 255
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.index ["email"], name: "invitations_email_index", unique: true
    t.index ["token"], name: "invitations_token_index"
  end

  create_table "properties", id: :uuid, default: nil, force: :cascade do |t|
    t.string "legacy_id", limit: 255
    t.string "name", limit: 255, null: false
    t.text "url", null: false
    t.text "description"
    t.integer "property_type", null: false
    t.uuid "user_id"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "estimated_monthly_page_views"
    t.integer "estimated_monthly_visitors"
    t.integer "alexa_site_rank"
    t.string "language", limit: 255, null: false
    t.string "programming_languages", limit: 255, default: [], null: false, array: true
    t.string "topic_categories", limit: 255, default: [], null: false, array: true
    t.text "screenshot_url"
    t.string "slug", limit: 255, null: false
    t.uuid "audience_id"
    t.string "excluded_advertisers", limit: 255, default: [], array: true
    t.uuid "template_id"
    t.boolean "no_api_house_ads", default: false, null: false
    t.index ["slug"], name: "properties_slug_index", unique: true
    t.index ["status"], name: "properties_status_index"
    t.index ["template_id"], name: "properties_template_id_index"
    t.index ["user_id"], name: "properties_user_id_index"
  end

  create_table "rememberables", id: :uuid, default: nil, force: :cascade do |t|
    t.string "series_hash", limit: 255
    t.string "token_hash", limit: 255
    t.datetime "token_created_at"
    t.uuid "user_id"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.index ["series_hash"], name: "rememberables_series_hash_index"
    t.index ["token_hash"], name: "rememberables_token_hash_index"
    t.index ["user_id", "series_hash", "token_hash"], name: "rememberables_user_id_series_hash_token_hash_index", unique: true
    t.index ["user_id"], name: "rememberables_user_id_index"
  end

  create_table "templates", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "slug", limit: 255
    t.text "description"
    t.text "body"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "templates_slug_index", unique: true
  end

  create_table "themes", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "template_id"
    t.string "name", limit: 255
    t.string "slug", limit: 255
    t.text "description"
    t.text "body"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id", "slug"], name: "themes_template_id_slug_index", unique: true
    t.index ["template_id"], name: "themes_template_id_index"
  end

  create_table "users", id: :uuid, default: nil, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "address_1", limit: 255
    t.string "address_2", limit: 255
    t.string "city", limit: 255
    t.string "region", limit: 255
    t.string "postal_code", limit: 255
    t.string "country", limit: 255
    t.string "roles", limit: 255, array: true
    t.decimal "revenue_rate", precision: 3, scale: 3, default: "0.5", null: false
    t.string "password_hash", limit: 255
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.integer "failed_attempts", default: 0
    t.datetime "locked_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "unlock_token", limit: 255
    t.datetime "remember_created_at"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.string "paypal_email", limit: 255
    t.string "company", limit: 255
    t.boolean "api_access", default: false, null: false
    t.string "api_key", limit: 255
    t.index ["email"], name: "users_email_index", unique: true
  end

  add_foreign_key "assets", "users", name: "assets_user_id_fkey"
  add_foreign_key "audiences", "campaigns", column: "fallback_campaign_id", name: "audiences_fallback_campaign_id_fkey"
  add_foreign_key "campaigns", "audiences", name: "campaigns_audience_id_fkey"
  add_foreign_key "campaigns", "creatives", name: "campaigns_creative_id_fkey"
  add_foreign_key "campaigns", "users", name: "campaigns_user_id_fkey"
  add_foreign_key "creatives", "assets", column: "large_image_asset_id", name: "creatives_large_image_asset_id_fkey"
  add_foreign_key "creatives", "assets", column: "small_image_asset_id", name: "creatives_small_image_asset_id_fkey"
  add_foreign_key "creatives", "assets", column: "wide_image_asset_id", name: "creatives_wide_image_asset_id_fkey"
  add_foreign_key "creatives", "users", name: "creatives_user_id_fkey"
  add_foreign_key "impressions", "campaigns", name: "impressions_campaign_id_fkey"
  add_foreign_key "impressions", "distributions", name: "impressions_distribution_id_fkey"
  add_foreign_key "impressions", "properties", name: "impressions_property_id_fkey"
  add_foreign_key "properties", "audiences", name: "properties_audience_id_fkey"
  add_foreign_key "properties", "templates", name: "properties_template_id_fkey"
  add_foreign_key "properties", "users", name: "properties_user_id_fkey"
  add_foreign_key "rememberables", "users", name: "rememberables_user_id_fkey", on_delete: :cascade
  add_foreign_key "themes", "templates", name: "themes_template_id_fkey"
end
