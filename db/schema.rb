# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 2018_11_14_202957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.jsonb "indexed_metadata", default: {}
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["content_type"], name: "index_active_storage_blobs_on_content_type"
    t.index ["filename"], name: "index_active_storage_blobs_on_filename"
    t.index ["indexed_metadata"], name: "index_active_storage_blobs_on_indexed_metadata", using: :gin
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "creative_id"
    t.string "status", null: false
    t.boolean "fallback", default: false, null: false
    t.string "name", null: false
    t.text "url", null: false
    t.date "start_date"
    t.date "end_date"
    t.boolean "us_hours_only", default: false
    t.boolean "weekdays_only", default: false
    t.integer "total_budget_cents", default: 0, null: false
    t.string "total_budget_currency", default: "USD", null: false
    t.integer "daily_budget_cents", default: 0, null: false
    t.string "daily_budget_currency", default: "USD", null: false
    t.integer "ecpm_cents", default: 0, null: false
    t.string "ecpm_currency", default: "USD", null: false
    t.string "countries", default: [], array: true
    t.string "keywords", default: [], array: true
    t.string "negative_keywords", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_campaigns_on_name"
    t.index ["countries"], name: "index_campaigns_on_countries", using: :gin
    t.index ["creative_id"], name: "index_campaigns_on_creative_id"
    t.index ["end_date"], name: "index_campaigns_on_end_date"
    t.index ["keywords"], name: "index_campaigns_on_keywords", using: :gin
    t.index ["negative_keywords"], name: "index_campaigns_on_negative_keywords", using: :gin
    t.index ["start_date"], name: "index_campaigns_on_start_date"
    t.index ["status"], name: "index_campaigns_on_status"
    t.index ["us_hours_only"], name: "index_campaigns_on_us_hours_only"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
    t.index ["weekdays_only"], name: "index_campaigns_on_weekdays_only"
  end

  create_table "creative_images", force: :cascade do |t|
    t.bigint "creative_id", null: false
    t.bigint "active_storage_attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_storage_attachment_id"], name: "index_creative_images_on_active_storage_attachment_id"
    t.index ["creative_id"], name: "index_creative_images_on_creative_id"
  end

  create_table "creatives", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "headline", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creatives_on_user_id"
  end

  create_table "impressions", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
  end

  create_table "impressions_2018_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2018_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2018_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2018_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2018_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2018_11_on_property_id"
  end

  create_table "impressions_2018_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2018_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2018_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2018_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2018_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2018_12_on_property_id"
  end

  create_table "impressions_2019_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_01_on_property_id"
  end

  create_table "impressions_2019_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_02_on_property_id"
  end

  create_table "impressions_2019_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_03_on_property_id"
  end

  create_table "impressions_2019_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_04_on_property_id"
  end

  create_table "impressions_2019_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_05_on_property_id"
  end

  create_table "impressions_2019_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_06_on_property_id"
  end

  create_table "impressions_2019_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_07_on_property_id"
  end

  create_table "impressions_2019_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_08_on_property_id"
  end

  create_table "impressions_2019_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_09_on_property_id"
  end

  create_table "impressions_2019_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_10_on_property_id"
  end

  create_table "impressions_2019_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_11_on_property_id"
  end

  create_table "impressions_2019_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2019_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2019_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2019_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2019_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2019_12_on_property_id"
  end

  create_table "impressions_2020_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_01_on_property_id"
  end

  create_table "impressions_2020_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_02_on_property_id"
  end

  create_table "impressions_2020_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_03_on_property_id"
  end

  create_table "impressions_2020_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_04_on_property_id"
  end

  create_table "impressions_2020_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_05_on_property_id"
  end

  create_table "impressions_2020_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_06_on_property_id"
  end

  create_table "impressions_2020_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_07_on_property_id"
  end

  create_table "impressions_2020_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_08_on_property_id"
  end

  create_table "impressions_2020_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_09_on_property_id"
  end

  create_table "impressions_2020_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_10_on_property_id"
  end

  create_table "impressions_2020_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_11_on_property_id"
  end

  create_table "impressions_2020_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2020_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2020_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2020_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2020_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2020_12_on_property_id"
  end

  create_table "impressions_2021_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_01_on_property_id"
  end

  create_table "impressions_2021_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_02_on_property_id"
  end

  create_table "impressions_2021_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_03_on_property_id"
  end

  create_table "impressions_2021_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_04_on_property_id"
  end

  create_table "impressions_2021_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_05_on_property_id"
  end

  create_table "impressions_2021_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_06_on_property_id"
  end

  create_table "impressions_2021_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_07_on_property_id"
  end

  create_table "impressions_2021_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_08_on_property_id"
  end

  create_table "impressions_2021_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_09_on_property_id"
  end

  create_table "impressions_2021_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_10_on_property_id"
  end

  create_table "impressions_2021_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_11_on_property_id"
  end

  create_table "impressions_2021_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2021_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2021_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2021_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2021_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2021_12_on_property_id"
  end

  create_table "impressions_2022_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_01_on_property_id"
  end

  create_table "impressions_2022_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_02_on_property_id"
  end

  create_table "impressions_2022_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_03_on_property_id"
  end

  create_table "impressions_2022_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_04_on_property_id"
  end

  create_table "impressions_2022_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_05_on_property_id"
  end

  create_table "impressions_2022_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_06_on_property_id"
  end

  create_table "impressions_2022_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_07_on_property_id"
  end

  create_table "impressions_2022_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_08_on_property_id"
  end

  create_table "impressions_2022_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_09_on_property_id"
  end

  create_table "impressions_2022_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_10_on_property_id"
  end

  create_table "impressions_2022_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_11_on_property_id"
  end

  create_table "impressions_2022_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2022_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2022_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2022_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2022_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2022_12_on_property_id"
  end

  create_table "impressions_2023_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_01_on_property_id"
  end

  create_table "impressions_2023_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_02_on_property_id"
  end

  create_table "impressions_2023_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_03_on_property_id"
  end

  create_table "impressions_2023_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_04_on_property_id"
  end

  create_table "impressions_2023_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_05_on_property_id"
  end

  create_table "impressions_2023_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_06_on_property_id"
  end

  create_table "impressions_2023_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_07_on_property_id"
  end

  create_table "impressions_2023_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_08_on_property_id"
  end

  create_table "impressions_2023_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_09_on_property_id"
  end

  create_table "impressions_2023_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_10_on_property_id"
  end

  create_table "impressions_2023_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_11_on_property_id"
  end

  create_table "impressions_2023_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2023_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2023_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2023_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2023_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2023_12_on_property_id"
  end

  create_table "impressions_2024_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_01_on_property_id"
  end

  create_table "impressions_2024_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_02_on_property_id"
  end

  create_table "impressions_2024_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_03_on_property_id"
  end

  create_table "impressions_2024_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_04_on_property_id"
  end

  create_table "impressions_2024_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_05_on_property_id"
  end

  create_table "impressions_2024_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_06_on_property_id"
  end

  create_table "impressions_2024_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_07_on_property_id"
  end

  create_table "impressions_2024_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_08_on_property_id"
  end

  create_table "impressions_2024_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_09_on_property_id"
  end

  create_table "impressions_2024_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_10_on_property_id"
  end

  create_table "impressions_2024_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_11_on_property_id"
  end

  create_table "impressions_2024_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2024_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2024_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2024_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2024_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2024_12_on_property_id"
  end

  create_table "impressions_2025_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_01_on_property_id"
  end

  create_table "impressions_2025_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_02_on_property_id"
  end

  create_table "impressions_2025_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_03_on_property_id"
  end

  create_table "impressions_2025_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_04_on_property_id"
  end

  create_table "impressions_2025_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_05_on_property_id"
  end

  create_table "impressions_2025_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_06_on_property_id"
  end

  create_table "impressions_2025_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_07_on_property_id"
  end

  create_table "impressions_2025_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_08_on_property_id"
  end

  create_table "impressions_2025_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_09_on_property_id"
  end

  create_table "impressions_2025_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_10_on_property_id"
  end

  create_table "impressions_2025_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_11_on_property_id"
  end

  create_table "impressions_2025_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2025_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2025_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2025_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2025_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2025_12_on_property_id"
  end

  create_table "impressions_2026_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_01_on_property_id"
  end

  create_table "impressions_2026_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_02_on_property_id"
  end

  create_table "impressions_2026_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_03_on_property_id"
  end

  create_table "impressions_2026_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_04_on_property_id"
  end

  create_table "impressions_2026_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_05_on_property_id"
  end

  create_table "impressions_2026_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_06_on_property_id"
  end

  create_table "impressions_2026_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_07_on_property_id"
  end

  create_table "impressions_2026_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_08_on_property_id"
  end

  create_table "impressions_2026_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_09_on_property_id"
  end

  create_table "impressions_2026_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_10_on_property_id"
  end

  create_table "impressions_2026_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_11_on_property_id"
  end

  create_table "impressions_2026_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2026_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2026_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2026_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2026_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2026_12_on_property_id"
  end

  create_table "impressions_2027_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_01_on_property_id"
  end

  create_table "impressions_2027_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_02_on_property_id"
  end

  create_table "impressions_2027_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_03_on_property_id"
  end

  create_table "impressions_2027_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_04_on_property_id"
  end

  create_table "impressions_2027_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_05_on_property_id"
  end

  create_table "impressions_2027_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_06_on_property_id"
  end

  create_table "impressions_2027_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_07_on_property_id"
  end

  create_table "impressions_2027_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_08_on_property_id"
  end

  create_table "impressions_2027_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_09_on_property_id"
  end

  create_table "impressions_2027_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_10_on_property_id"
  end

  create_table "impressions_2027_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_11_on_property_id"
  end

  create_table "impressions_2027_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2027_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2027_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2027_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2027_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2027_12_on_property_id"
  end

  create_table "impressions_2028_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_01_on_property_id"
  end

  create_table "impressions_2028_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_02_on_property_id"
  end

  create_table "impressions_2028_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_03_on_property_id"
  end

  create_table "impressions_2028_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_04_on_property_id"
  end

  create_table "impressions_2028_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_05_on_property_id"
  end

  create_table "impressions_2028_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_06_on_property_id"
  end

  create_table "impressions_2028_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_07_on_property_id"
  end

  create_table "impressions_2028_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_08_on_property_id"
  end

  create_table "impressions_2028_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_09_on_property_id"
  end

  create_table "impressions_2028_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_10_on_property_id"
  end

  create_table "impressions_2028_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_11_on_property_id"
  end

  create_table "impressions_2028_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2028_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2028_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2028_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2028_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2028_12_on_property_id"
  end

  create_table "impressions_2029_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_01_on_property_id"
  end

  create_table "impressions_2029_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_02_on_property_id"
  end

  create_table "impressions_2029_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_03_on_property_id"
  end

  create_table "impressions_2029_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_04_on_property_id"
  end

  create_table "impressions_2029_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_05_on_property_id"
  end

  create_table "impressions_2029_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_06_on_property_id"
  end

  create_table "impressions_2029_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_07_on_property_id"
  end

  create_table "impressions_2029_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_08_on_property_id"
  end

  create_table "impressions_2029_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_09_on_property_id"
  end

  create_table "impressions_2029_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_10_on_property_id"
  end

  create_table "impressions_2029_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_11_on_property_id"
  end

  create_table "impressions_2029_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2029_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2029_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2029_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2029_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2029_12_on_property_id"
  end

  create_table "impressions_2030_01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_01_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_01_on_property_id"
  end

  create_table "impressions_2030_02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_02_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_02_on_property_id"
  end

  create_table "impressions_2030_03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_03_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_03_on_property_id"
  end

  create_table "impressions_2030_04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_04_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_04_on_property_id"
  end

  create_table "impressions_2030_05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_05_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_05_on_property_id"
  end

  create_table "impressions_2030_06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_06_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_06_on_property_id"
  end

  create_table "impressions_2030_07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_07_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_07_on_property_id"
  end

  create_table "impressions_2030_08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_08_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_08_on_property_id"
  end

  create_table "impressions_2030_09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_09_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_09_on_property_id"
  end

  create_table "impressions_2030_10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_10_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_10_on_property_id"
  end

  create_table "impressions_2030_11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_11_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_11_on_property_id"
  end

  create_table "impressions_2030_12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2030_12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2030_12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2030_12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2030_12_on_payable"
    t.index ["property_id"], name: "index_impressions_2030_12_on_property_id"
  end

  create_table "impressions_default", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_default_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_default_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_default_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_default_on_payable"
    t.index ["property_id"], name: "index_impressions_default_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "property_type", null: false
    t.string "status", null: false
    t.string "name", null: false
    t.text "description"
    t.text "url", null: false
    t.string "ad_template", null: false
    t.string "ad_theme", null: false
    t.string "language", null: false
    t.string "keywords", default: [], null: false, array: true
    t.bigint "prohibited_advertisers", default: [], array: true
    t.boolean "prohibit_fallback_campaigns", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_properties_on_name"
    t.index ["keywords"], name: "index_properties_on_keywords", using: :gin
    t.index ["prohibited_advertisers"], name: "index_properties_on_prohibited_advertisers", using: :gin
    t.index ["property_type"], name: "index_properties_on_property_type"
    t.index ["status"], name: "index_properties_on_status"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "publisher_invoices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.money "amount", scale: 2, null: false
    t.string "currency", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.date "sent_at"
    t.date "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_publisher_invoices_on_end_date"
    t.index ["start_date"], name: "index_publisher_invoices_on_start_date"
    t.index ["user_id"], name: "index_publisher_invoices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "roles", default: [], array: true
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "company_name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "region"
    t.string "postal_code"
    t.string "country"
    t.boolean "api_access", default: false, null: false
    t.string "api_key"
    t.string "paypal_email"
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "us_resident", default: false
    t.text "bio"
    t.string "website_url"
    t.text "skills", default: [], array: true
    t.string "github_username"
    t.string "twitter_username"
    t.string "linkedin_username"
    t.index "lower((email)::text)", name: "index_users_on_email", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end
end
