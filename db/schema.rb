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

ActiveRecord::Schema.define(version: 2018_10_17_152837) do

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions-2018-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2018-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2018-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2018-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2018-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2018-11_on_property_id"
  end

  create_table "impressions-2018-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2018-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2018-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2018-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2018-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2018-12_on_property_id"
  end

  create_table "impressions-2019-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-01_on_property_id"
  end

  create_table "impressions-2019-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-02_on_property_id"
  end

  create_table "impressions-2019-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-03_on_property_id"
  end

  create_table "impressions-2019-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-04_on_property_id"
  end

  create_table "impressions-2019-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-05_on_property_id"
  end

  create_table "impressions-2019-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-06_on_property_id"
  end

  create_table "impressions-2019-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-07_on_property_id"
  end

  create_table "impressions-2019-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-08_on_property_id"
  end

  create_table "impressions-2019-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-09_on_property_id"
  end

  create_table "impressions-2019-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-10_on_property_id"
  end

  create_table "impressions-2019-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-11_on_property_id"
  end

  create_table "impressions-2019-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2019-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2019-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2019-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2019-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2019-12_on_property_id"
  end

  create_table "impressions-2020-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-01_on_property_id"
  end

  create_table "impressions-2020-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-02_on_property_id"
  end

  create_table "impressions-2020-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-03_on_property_id"
  end

  create_table "impressions-2020-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-04_on_property_id"
  end

  create_table "impressions-2020-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-05_on_property_id"
  end

  create_table "impressions-2020-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-06_on_property_id"
  end

  create_table "impressions-2020-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-07_on_property_id"
  end

  create_table "impressions-2020-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-08_on_property_id"
  end

  create_table "impressions-2020-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-09_on_property_id"
  end

  create_table "impressions-2020-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-10_on_property_id"
  end

  create_table "impressions-2020-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-11_on_property_id"
  end

  create_table "impressions-2020-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2020-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2020-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2020-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2020-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2020-12_on_property_id"
  end

  create_table "impressions-2021-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-01_on_property_id"
  end

  create_table "impressions-2021-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-02_on_property_id"
  end

  create_table "impressions-2021-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-03_on_property_id"
  end

  create_table "impressions-2021-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-04_on_property_id"
  end

  create_table "impressions-2021-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-05_on_property_id"
  end

  create_table "impressions-2021-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-06_on_property_id"
  end

  create_table "impressions-2021-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-07_on_property_id"
  end

  create_table "impressions-2021-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-08_on_property_id"
  end

  create_table "impressions-2021-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-09_on_property_id"
  end

  create_table "impressions-2021-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-10_on_property_id"
  end

  create_table "impressions-2021-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-11_on_property_id"
  end

  create_table "impressions-2021-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2021-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2021-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2021-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2021-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2021-12_on_property_id"
  end

  create_table "impressions-2022-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-01_on_property_id"
  end

  create_table "impressions-2022-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-02_on_property_id"
  end

  create_table "impressions-2022-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-03_on_property_id"
  end

  create_table "impressions-2022-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-04_on_property_id"
  end

  create_table "impressions-2022-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-05_on_property_id"
  end

  create_table "impressions-2022-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-06_on_property_id"
  end

  create_table "impressions-2022-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-07_on_property_id"
  end

  create_table "impressions-2022-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-08_on_property_id"
  end

  create_table "impressions-2022-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-09_on_property_id"
  end

  create_table "impressions-2022-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-10_on_property_id"
  end

  create_table "impressions-2022-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-11_on_property_id"
  end

  create_table "impressions-2022-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2022-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2022-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2022-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2022-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2022-12_on_property_id"
  end

  create_table "impressions-2023-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-01_on_property_id"
  end

  create_table "impressions-2023-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-02_on_property_id"
  end

  create_table "impressions-2023-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-03_on_property_id"
  end

  create_table "impressions-2023-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-04_on_property_id"
  end

  create_table "impressions-2023-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-05_on_property_id"
  end

  create_table "impressions-2023-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-06_on_property_id"
  end

  create_table "impressions-2023-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-07_on_property_id"
  end

  create_table "impressions-2023-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-08_on_property_id"
  end

  create_table "impressions-2023-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-09_on_property_id"
  end

  create_table "impressions-2023-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-10_on_property_id"
  end

  create_table "impressions-2023-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-11_on_property_id"
  end

  create_table "impressions-2023-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2023-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2023-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2023-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2023-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2023-12_on_property_id"
  end

  create_table "impressions-2024-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-01_on_property_id"
  end

  create_table "impressions-2024-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-02_on_property_id"
  end

  create_table "impressions-2024-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-03_on_property_id"
  end

  create_table "impressions-2024-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-04_on_property_id"
  end

  create_table "impressions-2024-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-05_on_property_id"
  end

  create_table "impressions-2024-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-06_on_property_id"
  end

  create_table "impressions-2024-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-07_on_property_id"
  end

  create_table "impressions-2024-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-08_on_property_id"
  end

  create_table "impressions-2024-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-09_on_property_id"
  end

  create_table "impressions-2024-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-10_on_property_id"
  end

  create_table "impressions-2024-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-11_on_property_id"
  end

  create_table "impressions-2024-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2024-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2024-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2024-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2024-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2024-12_on_property_id"
  end

  create_table "impressions-2025-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-01_on_property_id"
  end

  create_table "impressions-2025-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-02_on_property_id"
  end

  create_table "impressions-2025-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-03_on_property_id"
  end

  create_table "impressions-2025-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-04_on_property_id"
  end

  create_table "impressions-2025-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-05_on_property_id"
  end

  create_table "impressions-2025-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-06_on_property_id"
  end

  create_table "impressions-2025-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-07_on_property_id"
  end

  create_table "impressions-2025-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-08_on_property_id"
  end

  create_table "impressions-2025-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-09_on_property_id"
  end

  create_table "impressions-2025-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-10_on_property_id"
  end

  create_table "impressions-2025-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-11_on_property_id"
  end

  create_table "impressions-2025-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2025-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2025-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2025-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2025-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2025-12_on_property_id"
  end

  create_table "impressions-2026-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-01_on_property_id"
  end

  create_table "impressions-2026-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-02_on_property_id"
  end

  create_table "impressions-2026-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-03_on_property_id"
  end

  create_table "impressions-2026-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-04_on_property_id"
  end

  create_table "impressions-2026-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-05_on_property_id"
  end

  create_table "impressions-2026-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-06_on_property_id"
  end

  create_table "impressions-2026-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-07_on_property_id"
  end

  create_table "impressions-2026-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-08_on_property_id"
  end

  create_table "impressions-2026-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-09_on_property_id"
  end

  create_table "impressions-2026-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-10_on_property_id"
  end

  create_table "impressions-2026-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-11_on_property_id"
  end

  create_table "impressions-2026-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2026-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2026-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2026-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2026-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2026-12_on_property_id"
  end

  create_table "impressions-2027-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-01_on_property_id"
  end

  create_table "impressions-2027-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-02_on_property_id"
  end

  create_table "impressions-2027-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-03_on_property_id"
  end

  create_table "impressions-2027-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-04_on_property_id"
  end

  create_table "impressions-2027-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-05_on_property_id"
  end

  create_table "impressions-2027-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-06_on_property_id"
  end

  create_table "impressions-2027-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-07_on_property_id"
  end

  create_table "impressions-2027-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-08_on_property_id"
  end

  create_table "impressions-2027-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-09_on_property_id"
  end

  create_table "impressions-2027-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-10_on_property_id"
  end

  create_table "impressions-2027-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-11_on_property_id"
  end

  create_table "impressions-2027-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2027-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2027-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2027-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2027-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2027-12_on_property_id"
  end

  create_table "impressions-2028-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-01_on_property_id"
  end

  create_table "impressions-2028-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-02_on_property_id"
  end

  create_table "impressions-2028-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-03_on_property_id"
  end

  create_table "impressions-2028-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-04_on_property_id"
  end

  create_table "impressions-2028-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-05_on_property_id"
  end

  create_table "impressions-2028-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-06_on_property_id"
  end

  create_table "impressions-2028-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-07_on_property_id"
  end

  create_table "impressions-2028-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-08_on_property_id"
  end

  create_table "impressions-2028-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-09_on_property_id"
  end

  create_table "impressions-2028-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-10_on_property_id"
  end

  create_table "impressions-2028-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-11_on_property_id"
  end

  create_table "impressions-2028-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2028-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2028-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2028-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2028-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2028-12_on_property_id"
  end

  create_table "impressions-2029-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-01_on_property_id"
  end

  create_table "impressions-2029-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-02_on_property_id"
  end

  create_table "impressions-2029-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-03_on_property_id"
  end

  create_table "impressions-2029-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-04_on_property_id"
  end

  create_table "impressions-2029-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-05_on_property_id"
  end

  create_table "impressions-2029-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-06_on_property_id"
  end

  create_table "impressions-2029-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-07_on_property_id"
  end

  create_table "impressions-2029-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-08_on_property_id"
  end

  create_table "impressions-2029-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-09_on_property_id"
  end

  create_table "impressions-2029-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-10_on_property_id"
  end

  create_table "impressions-2029-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-11_on_property_id"
  end

  create_table "impressions-2029-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2029-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2029-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2029-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2029-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2029-12_on_property_id"
  end

  create_table "impressions-2030-01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-01_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-01_on_property_id"
  end

  create_table "impressions-2030-02", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-02_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-02_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-02_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-02_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-02_on_property_id"
  end

  create_table "impressions-2030-03", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-03_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-03_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-03_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-03_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-03_on_property_id"
  end

  create_table "impressions-2030-04", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-04_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-04_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-04_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-04_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-04_on_property_id"
  end

  create_table "impressions-2030-05", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-05_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-05_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-05_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-05_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-05_on_property_id"
  end

  create_table "impressions-2030-06", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-06_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-06_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-06_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-06_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-06_on_property_id"
  end

  create_table "impressions-2030-07", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-07_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-07_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-07_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-07_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-07_on_property_id"
  end

  create_table "impressions-2030-08", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-08_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-08_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-08_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-08_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-08_on_property_id"
  end

  create_table "impressions-2030-09", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-09_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-09_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-09_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-09_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-09_on_property_id"
  end

  create_table "impressions-2030-10", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-10_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-10_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-10_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-10_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-10_on_property_id"
  end

  create_table "impressions-2030-11", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-11_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-11_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-11_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-11_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-11_on_property_id"
  end

  create_table "impressions-2030-12", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions-2030-12_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions-2030-12_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions-2030-12_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions-2030-12_on_payable"
    t.index ["property_id"], name: "index_impressions-2030-12_on_property_id"
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
    t.index "lower((email)::text)", name: "index_users_on_email", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
