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

ActiveRecord::Schema.define(version: 2018_12_01_133512) do

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

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "counters", force: :cascade do |t|
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.string "scope", null: false
    t.string "segment"
    t.bigint "count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "scope", "segment"], name: "index_counters_on_record_and_scope_and_segment", unique: true
    t.index ["record_type", "record_id", "scope"], name: "index_counters_on_record_type_and_record_id_and_scope"
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
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
  end

  create_table "impressions_2017_12_advertiser_101", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_101_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_101_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_101_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_101_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_101_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_101_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_101_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_101_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_101_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_102", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_102_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_102_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_102_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_102_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_102_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_102_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_102_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_102_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_102_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_22", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_22_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_22_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_22_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_22_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_22_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_22_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_22_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_22_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_22_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_25_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_33_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_36", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_36_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_36_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_36_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_36_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_36_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_36_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_36_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_36_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_36_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_54_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_77", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_77_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_77_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_77_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_77_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_77_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_77_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_77_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_77_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_77_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_85_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_89_property_name_idx"
  end

  create_table "impressions_2017_12_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2017_12_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2017_12_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2017_12_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2017_12_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2017_12_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2017_12_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2017_12_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2017_12_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2017_12_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2017_12_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_101", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_101_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_101_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_101_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_101_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_101_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_101_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_101_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_101_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_101_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_102", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_102_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_102_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_102_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_102_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_102_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_102_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_102_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_102_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_102_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_22", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_22_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_22_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_22_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_22_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_22_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_22_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_22_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_22_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_22_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_24", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_24_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_24_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_24_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_24_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_24_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_24_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_24_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_24_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_24_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_25_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_33_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_36", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_36_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_36_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_36_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_36_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_36_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_36_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_36_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_36_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_36_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_54_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_6", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_6_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_6_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_6_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_6_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_6_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_6_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_6_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_6_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_6_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_76", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_76_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_76_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_76_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_76_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_76_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_76_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_76_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_76_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_76_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_77", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_77_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_77_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_77_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_77_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_77_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_77_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_77_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_77_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_77_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_78", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_78_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_78_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_78_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_78_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_78_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_78_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_78_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_78_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_78_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_79", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_79_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_79_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_79_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_79_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_79_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_79_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_79_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_79_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_79_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_85_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_87", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_87_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_87_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_87_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_87_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_87_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_87_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_87_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_87_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_87_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_92", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_92_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_92_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_92_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_92_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_92_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_92_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_92_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_92_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_92_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_93", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_93_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_93_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_93_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_93_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_93_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_93_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_93_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_93_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_93_property_name_idx"
  end

  create_table "impressions_2018_01_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_01_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_01_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_01_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_01_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_01_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_01_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_01_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_01_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_01_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_01_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_101", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_101_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_101_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_101_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_101_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_101_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_101_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_101_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_101_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_101_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_102", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_102_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_102_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_102_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_102_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_102_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_102_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_102_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_102_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_102_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_14", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_14_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_14_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_14_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_14_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_14_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_14_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_14_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_14_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_14_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_24", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_24_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_24_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_24_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_24_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_24_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_24_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_24_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_24_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_24_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_25_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_33_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_36", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_36_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_36_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_36_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_36_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_36_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_36_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_36_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_36_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_36_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_39", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_39_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_39_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_39_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_39_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_39_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_39_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_39_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_39_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_39_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_5", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_5_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_5_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_5_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_5_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_5_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_5_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_5_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_5_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_5_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_54_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_6", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_6_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_6_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_6_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_6_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_6_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_6_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_6_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_6_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_6_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_76", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_76_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_76_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_76_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_76_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_76_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_76_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_76_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_76_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_76_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_77", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_77_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_77_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_77_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_77_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_77_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_77_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_77_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_77_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_77_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_78", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_78_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_78_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_78_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_78_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_78_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_78_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_78_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_78_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_78_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_79", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_79_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_79_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_79_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_79_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_79_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_79_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_79_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_79_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_79_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_8", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_8_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_8_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_8_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_8_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_8_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_8_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_8_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_8_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_8_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_86", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_86_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_86_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_86_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_86_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_86_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_86_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_86_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_86_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_86_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_87", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_87_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_87_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_87_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_87_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_87_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_87_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_87_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_87_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_87_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_92", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_92_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_92_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_92_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_92_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_92_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_92_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_92_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_92_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_92_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_93", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_93_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_93_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_93_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_93_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_93_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_93_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_93_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_93_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_93_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_02_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_02_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_02_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_02_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_02_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_02_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_02_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_02_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_02_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_02_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_02_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_101", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_101_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_101_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_101_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_101_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_101_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_101_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_101_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_101_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_101_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_14", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_14_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_14_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_14_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_14_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_14_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_14_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_14_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_14_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_14_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_2", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_2_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_2_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_2_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_2_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_2_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_2_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_2_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_2_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_2_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_24", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_24_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_24_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_24_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_24_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_24_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_24_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_24_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_24_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_24_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_25_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_36", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_36_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_36_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_36_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_36_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_36_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_36_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_36_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_36_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_36_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_39", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_39_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_39_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_39_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_39_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_39_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_39_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_39_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_39_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_39_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_42", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_42_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_42_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_42_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_42_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_42_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_42_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_42_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_42_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_42_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_46", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_46_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_46_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_46_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_46_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_46_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_46_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_46_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_46_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_46_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_49", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_49_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_49_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_49_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_49_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_49_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_49_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_49_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_49_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_49_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_5", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_5_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_5_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_5_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_5_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_5_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_5_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_5_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_5_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_5_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_54_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_60", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_60_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_60_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_60_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_60_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_60_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_60_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_60_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_60_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_60_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_72", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_72_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_72_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_72_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_72_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_72_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_72_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_72_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_72_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_72_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_79", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_79_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_79_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_79_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_79_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_79_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_79_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_79_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_79_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_79_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_8", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_8_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_8_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_8_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_8_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_8_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_8_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_8_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_8_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_8_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_86", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_86_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_86_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_86_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_86_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_86_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_86_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_86_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_86_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_86_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_93", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_93_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_93_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_93_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_93_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_93_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_93_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_93_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_93_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_93_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_94", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_94_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_94_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_94_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_94_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_94_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_94_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_94_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_94_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_94_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_03_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_03_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_03_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_03_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_03_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_03_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_03_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_03_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_03_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_03_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_03_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_100", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_100_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_100_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_100_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_100_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_100_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_100_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_100_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_100_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_100_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_101", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_101_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_101_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_101_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_101_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_101_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_101_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_101_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_101_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_101_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_19", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_19_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_19_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_19_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_19_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_19_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_19_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_19_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_19_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_19_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_2", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_2_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_2_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_2_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx33"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_2_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_2_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_2_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_2_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_2_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_2_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_22", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_22_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_22_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_22_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_22_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_22_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_22_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_22_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_22_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_22_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_24", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_24_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_24_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_24_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_24_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_24_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_24_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_24_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_24_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_24_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_25_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_39", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_39_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_39_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_39_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_39_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_39_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_39_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_39_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_39_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_39_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_42", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_42_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_42_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_42_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx30"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_42_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_42_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_42_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_42_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_42_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_42_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_46", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_46_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_46_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_46_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_46_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_46_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_46_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_46_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_46_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_46_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_49", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_49_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_49_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_49_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_49_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_49_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_49_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_49_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_49_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_49_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_5", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_5_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_5_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_5_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_5_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_5_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_5_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_5_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_5_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_5_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_54_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_56", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_56_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_56_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_56_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx31"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_56_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_56_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_56_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_56_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_56_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_56_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_6", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_6_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_6_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_6_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx28"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_6_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_6_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_6_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_6_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_6_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_6_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_60", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_60_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_60_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_60_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_60_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_60_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_60_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_60_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_60_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_60_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_61", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_61_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_61_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_61_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_61_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_61_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_61_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_61_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_61_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_61_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_67", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_67_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_67_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_67_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_67_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_67_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_67_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_67_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_67_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_67_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_72", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_72_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_72_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_72_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx32"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_72_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_72_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_72_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_72_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_72_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_72_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_79", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_79_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_79_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_79_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_79_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_79_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_79_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_79_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_79_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_79_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_83", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_83_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_83_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_83_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx29"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_83_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_83_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_83_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_83_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_83_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_83_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_85_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_86", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_86_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_86_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_86_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_86_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_86_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_86_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_86_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_86_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_86_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_93", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_93_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_93_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_93_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_93_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_93_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_93_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_93_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_93_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_93_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_94", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_94_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_94_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_94_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_94_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_94_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_94_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_94_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_94_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_94_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_04_advertiser_98", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_04_advertiser_98_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_04_advertiser_98_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_04_advertiser_98_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_04_advertise_campaign_name_property_name_idx27"
    t.index ["campaign_name"], name: "impressions_2018_04_advertiser_98_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_04_advertiser_98_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_04_advertiser_98_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_04_advertiser_98_payable_idx"
    t.index ["property_id"], name: "impressions_2018_04_advertiser_98_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_04_advertiser_98_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_100", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_100_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_100_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_100_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_100_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_100_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_100_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_100_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_100_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_100_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_15", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_15_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_15_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_15_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx27"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_15_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_15_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_15_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_15_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_15_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_15_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_19", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_19_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_19_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_19_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_19_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_19_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_19_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_19_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_19_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_19_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_2", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_2_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_2_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_2_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx29"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_2_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_2_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_2_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_2_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_2_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_2_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_22", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_22_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_22_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_22_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_22_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_22_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_22_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_22_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_22_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_22_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_25_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_39", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_39_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_39_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_39_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx31"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_39_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_39_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_39_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_39_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_39_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_39_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_49", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_49_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_49_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_49_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_49_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_49_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_49_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_49_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_49_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_49_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_52", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_52_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_52_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_52_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_52_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_52_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_52_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_52_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_52_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_52_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx28"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_54_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_56", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_56_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_56_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_56_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_56_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_56_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_56_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_56_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_56_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_56_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_6", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_6_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_6_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_6_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_6_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_6_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_6_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_6_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_6_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_6_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_60", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_60_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_60_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_60_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_60_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_60_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_60_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_60_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_60_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_60_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_61", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_61_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_61_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_61_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx30"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_61_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_61_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_61_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_61_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_61_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_61_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_63", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_63_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_63_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_63_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_63_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_63_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_63_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_63_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_63_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_63_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_64", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_64_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_64_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_64_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_64_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_64_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_64_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_64_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_64_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_64_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_67", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_67_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_67_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_67_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_67_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_67_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_67_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_67_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_67_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_67_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_83", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_83_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_83_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_83_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_83_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_83_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_83_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_83_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_83_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_83_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_85_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_9", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_9_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_9_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_9_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_9_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_9_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_9_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_9_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_9_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_9_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_93", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_93_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_93_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_93_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_93_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_93_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_93_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_93_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_93_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_93_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_94", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_94_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_94_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_94_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_94_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_94_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_94_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_94_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_94_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_94_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_05_advertiser_98", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_05_advertiser_98_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_05_advertiser_98_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_05_advertiser_98_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_05_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_05_advertiser_98_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_05_advertiser_98_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_05_advertiser_98_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_05_advertiser_98_payable_idx"
    t.index ["property_id"], name: "impressions_2018_05_advertiser_98_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_05_advertiser_98_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_100", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_100_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_100_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_100_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_100_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_100_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_100_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_100_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_100_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_100_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_15", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_15_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_15_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_15_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_15_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_15_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_15_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_15_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_15_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_15_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_21", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_21_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_21_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_21_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_21_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_21_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_21_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_21_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_21_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_21_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_22", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_22_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_22_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_22_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_22_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_22_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_22_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_22_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_22_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_22_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_25", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_25_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_25_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_25_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_25_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_25_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_25_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_25_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_25_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_25_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_32", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_32_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_32_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_32_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_32_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_32_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_32_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_32_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_32_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_32_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_52", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_52_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_52_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_52_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_52_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_52_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_52_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_52_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_52_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_52_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_54", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_54_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_54_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_54_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_54_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_54_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_54_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_54_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_54_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_54_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_6", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_6_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_6_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_6_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_6_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_6_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_6_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_6_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_6_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_6_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_61", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_61_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_61_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_61_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_61_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_61_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_61_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_61_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_61_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_61_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_63", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_63_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_63_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_63_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_63_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_63_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_63_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_63_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_63_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_63_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_64", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_64_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_64_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_64_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_64_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_64_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_64_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_64_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_64_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_64_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_67", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_67_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_67_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_67_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_67_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_67_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_67_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_67_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_67_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_67_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_69", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_69_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_69_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_69_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_69_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_69_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_69_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_69_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_69_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_69_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_70", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_70_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_70_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_70_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_70_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_70_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_70_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_70_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_70_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_70_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_85_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_9", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_9_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_9_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_9_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_9_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_9_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_9_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_9_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_9_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_9_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_94", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_94_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_94_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_94_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_94_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_94_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_94_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_94_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_94_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_94_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_06_advertiser_98", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_06_advertiser_98_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_06_advertiser_98_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_06_advertiser_98_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_06_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_06_advertiser_98_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_06_advertiser_98_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_06_advertiser_98_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_06_advertiser_98_payable_idx"
    t.index ["property_id"], name: "impressions_2018_06_advertiser_98_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_06_advertiser_98_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_100", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_100_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_100_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_100_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_100_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_100_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_100_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_100_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_100_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_100_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_21", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_21_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_21_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_21_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_21_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_21_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_21_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_21_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_21_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_21_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_22", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_22_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_22_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_22_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_22_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_22_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_22_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_22_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_22_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_22_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_23", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_23_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_23_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_23_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_23_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_23_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_23_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_23_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_23_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_23_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_3", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_3_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_3_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_3_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_3_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_3_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_3_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_3_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_3_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_3_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_32", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_32_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_32_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_32_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_32_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_32_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_32_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_32_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_32_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_32_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_33_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_4", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_4_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_4_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_4_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_4_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_4_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_4_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_4_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_4_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_4_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_50", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_50_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_50_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_50_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_50_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_50_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_50_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_50_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_50_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_50_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_52", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_52_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_52_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_52_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_52_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_52_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_52_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_52_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_52_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_52_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_56", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_56_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_56_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_56_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_56_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_56_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_56_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_56_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_56_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_56_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_63", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_63_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_63_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_63_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_63_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_63_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_63_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_63_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_63_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_63_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_64", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_64_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_64_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_64_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_64_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_64_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_64_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_64_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_64_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_64_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_65", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_65_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_65_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_65_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx31"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_65_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_65_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_65_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_65_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_65_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_65_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_67", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_67_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_67_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_67_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx27"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_67_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_67_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_67_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_67_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_67_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_67_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_69", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_69_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_69_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_69_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_69_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_69_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_69_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_69_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_69_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_69_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_70", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_70_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_70_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_70_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx28"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_70_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_70_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_70_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_70_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_70_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_70_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_72", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_72_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_72_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_72_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_72_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_72_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_72_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_72_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_72_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_72_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_78", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_78_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_78_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_78_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_78_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_78_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_78_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_78_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_78_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_78_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx30"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_85_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_9", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_9_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_9_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_9_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_9_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_9_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_9_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_9_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_9_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_9_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertise_campaign_name_property_name_idx29"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_07_advertiser_99", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_07_advertiser_99_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_07_advertiser_99_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_07_advertiser_99_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_07_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_07_advertiser_99_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_07_advertiser_99_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_07_advertiser_99_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_07_advertiser_99_payable_idx"
    t.index ["property_id"], name: "impressions_2018_07_advertiser_99_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_07_advertiser_99_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_100", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_100_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_100_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_100_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_100_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_100_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_100_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_100_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_100_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_100_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_15", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_15_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_15_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_15_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_15_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_15_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_15_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_15_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_15_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_15_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_21", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_21_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_21_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_21_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_21_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_21_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_21_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_21_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_21_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_21_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_23", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_23_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_23_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_23_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_23_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_23_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_23_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_23_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_23_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_23_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_26", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_26_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_26_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_26_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_26_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_26_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_26_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_26_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_26_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_26_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_3", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_3_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_3_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_3_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_3_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_3_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_3_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_3_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_3_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_3_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_33_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_4", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_4_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_4_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_4_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx34"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_4_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_4_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_4_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_4_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_4_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_4_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_45", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_45_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_45_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_45_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx30"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_45_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_45_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_45_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_45_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_45_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_45_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_5", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_5_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_5_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_5_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_5_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_5_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_5_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_5_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_5_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_5_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_50", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_50_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_50_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_50_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_50_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_50_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_50_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_50_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_50_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_50_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_56", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_56_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_56_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_56_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx28"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_56_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_56_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_56_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_56_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_56_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_56_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx32"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_63", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_63_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_63_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_63_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_63_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_63_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_63_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_63_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_63_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_63_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_64", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_64_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_64_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_64_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_64_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_64_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_64_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_64_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_64_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_64_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_65", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_65_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_65_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_65_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx33"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_65_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_65_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_65_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_65_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_65_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_65_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_67", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_67_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_67_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_67_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_67_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_67_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_67_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_67_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_67_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_67_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_70", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_70_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_70_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_70_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_70_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_70_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_70_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_70_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_70_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_70_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_72", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_72_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_72_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_72_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_72_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_72_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_72_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_72_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_72_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_72_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_77", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_77_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_77_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_77_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx31"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_77_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_77_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_77_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_77_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_77_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_77_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_78", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_78_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_78_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_78_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx27"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_78_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_78_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_78_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_78_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_78_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_78_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_83", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_83_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_83_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_83_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_83_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_83_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_83_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_83_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_83_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_83_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_85", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_85_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_85_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_85_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_85_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_85_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_85_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_85_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_85_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_85_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_88", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_88_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_88_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_88_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_88_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_88_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_88_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_88_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_88_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_88_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_96", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_96_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_96_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_96_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_96_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_96_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_96_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_96_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_96_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_96_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx29"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_08_advertiser_99", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_08_advertiser_99_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_08_advertiser_99_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_08_advertiser_99_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_08_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_08_advertiser_99_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_08_advertiser_99_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_08_advertiser_99_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_08_advertiser_99_payable_idx"
    t.index ["property_id"], name: "impressions_2018_08_advertiser_99_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_08_advertiser_99_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_13", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_13_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_13_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_13_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_13_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_13_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_13_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_13_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_13_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_13_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_15", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_15_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_15_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_15_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_15_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_15_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_15_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_15_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_15_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_15_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx33"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_21", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_21_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_21_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_21_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx30"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_21_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_21_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_21_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_21_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_21_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_21_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_23", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_23_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_23_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_23_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_23_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_23_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_23_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_23_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_23_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_23_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_26", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_26_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_26_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_26_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_26_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_26_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_26_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_26_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_26_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_26_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_28", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_28_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_28_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_28_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx27"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_28_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_28_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_28_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_28_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_28_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_28_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_3", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_3_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_3_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_3_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_3_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_3_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_3_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_3_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_3_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_3_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_33_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_43", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_43_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_43_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_43_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx29"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_43_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_43_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_43_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_43_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_43_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_43_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_45", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_45_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_45_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_45_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_45_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_45_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_45_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_45_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_45_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_45_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_5", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_5_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_5_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_5_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_5_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_5_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_5_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_5_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_5_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_5_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_50", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_50_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_50_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_50_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_50_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_50_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_50_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_50_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_50_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_50_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_56", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_56_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_56_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_56_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_56_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_56_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_56_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_56_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_56_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_56_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx28"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_63", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_63_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_63_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_63_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_63_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_63_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_63_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_63_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_63_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_63_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_64", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_64_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_64_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_64_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_64_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_64_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_64_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_64_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_64_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_64_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_72", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_72_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_72_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_72_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx32"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_72_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_72_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_72_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_72_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_72_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_72_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_77", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_77_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_77_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_77_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_77_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_77_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_77_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_77_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_77_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_77_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_78", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_78_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_78_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_78_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_78_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_78_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_78_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_78_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_78_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_78_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_83", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_83_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_83_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_83_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_83_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_83_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_83_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_83_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_83_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_83_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_87", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_87_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_87_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_87_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_87_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_87_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_87_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_87_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_87_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_87_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_88", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_88_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_88_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_88_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_88_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_88_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_88_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_88_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_88_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_88_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx31"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_96", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_96_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_96_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_96_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_96_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_96_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_96_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_96_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_96_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_96_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_97", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_97_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_97_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_97_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_97_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_97_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_97_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_97_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_97_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_97_property_name_idx"
  end

  create_table "impressions_2018_09_advertiser_99", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_09_advertiser_99_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_09_advertiser_99_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_09_advertiser_99_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_09_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_09_advertiser_99_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_09_advertiser_99_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_09_advertiser_99_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_09_advertiser_99_payable_idx"
    t.index ["property_id"], name: "impressions_2018_09_advertiser_99_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_09_advertiser_99_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_13", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_13_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_13_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_13_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_13_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_13_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_13_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_13_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_13_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_13_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_15", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_15_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_15_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_15_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_15_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_15_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_15_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_15_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_15_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_15_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_16", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_16_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_16_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_16_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_16_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_16_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_16_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_16_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_16_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_16_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_20", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_20_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_20_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_20_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_20_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_20_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_20_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_20_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_20_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_20_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_21", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_21_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_21_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_21_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_21_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_21_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_21_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_21_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_21_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_21_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_23", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_23_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_23_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_23_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_23_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_23_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_23_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_23_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_23_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_23_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_28", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_28_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_28_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_28_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_28_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_28_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_28_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_28_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_28_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_28_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_3", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_3_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_3_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_3_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_3_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_3_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_3_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_3_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_3_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_3_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_33", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_33_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_33_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_33_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_33_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_33_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_33_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_33_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_33_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_33_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_43", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_43_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_43_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_43_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_43_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_43_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_43_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_43_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_43_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_43_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_47", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_47_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_47_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_47_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_47_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_47_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_47_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_47_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_47_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_47_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_5", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_5_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_5_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_5_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_5_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_5_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_5_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_5_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_5_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_5_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_57", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_57_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_57_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_57_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_57_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_57_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_57_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_57_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_57_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_57_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx26"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_71", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_71_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_71_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_71_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_71_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_71_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_71_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_71_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_71_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_71_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_75", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_75_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_75_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_75_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_75_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_75_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_75_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_75_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_75_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_75_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_77", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_77_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_77_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_77_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx28"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_77_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_77_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_77_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_77_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_77_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_77_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_78", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_78_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_78_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_78_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx27"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_78_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_78_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_78_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_78_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_78_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_78_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_83", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_83_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_83_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_83_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_83_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_83_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_83_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_83_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_83_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_83_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_87", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_87_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_87_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_87_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_87_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_87_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_87_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_87_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_87_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_87_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_89", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_89_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_89_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_89_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_89_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_89_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_89_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_89_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_89_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_89_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_91", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_91_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_91_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_91_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_91_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_91_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_91_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_91_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_91_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_91_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_96", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_96_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_96_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_96_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_96_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_96_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_96_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_96_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_96_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_96_property_name_idx"
  end

  create_table "impressions_2018_10_advertiser_99", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_10_advertiser_99_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_10_advertiser_99_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_10_advertiser_99_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_10_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_10_advertiser_99_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_10_advertiser_99_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_10_advertiser_99_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_10_advertiser_99_payable_idx"
    t.index ["property_id"], name: "impressions_2018_10_advertiser_99_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_10_advertiser_99_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_11", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_11_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_11_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_11_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_11_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_11_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_11_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_11_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_11_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_11_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_13", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_13_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_13_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_13_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx21"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_13_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_13_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_13_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_13_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_13_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_13_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_15", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_15_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_15_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_15_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_15_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_15_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_15_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_15_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_15_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_15_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_20", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_20_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_20_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_20_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx25"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_20_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_20_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_20_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_20_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_20_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_20_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_23", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_23_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_23_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_23_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_23_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_23_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_23_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_23_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_23_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_23_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_28", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_28_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_28_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_28_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_28_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_28_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_28_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_28_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_28_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_28_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_3", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_3_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_3_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_3_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx22"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_3_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_3_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_3_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_3_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_3_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_3_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_34", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_34_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_34_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_34_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_34_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_34_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_34_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_34_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_34_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_34_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_37", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_37_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_37_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_37_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx23"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_37_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_37_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_37_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_37_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_37_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_37_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_43", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_43_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_43_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_43_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_43_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_43_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_43_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_43_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_43_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_43_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_45", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_45_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_45_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_45_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_45_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_45_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_45_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_45_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_45_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_45_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_47", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_47_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_47_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_47_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_47_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_47_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_47_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_47_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_47_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_47_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_57", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_57_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_57_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_57_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_57_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_57_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_57_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_57_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_57_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_57_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_59", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_59_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_59_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_59_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_59_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_59_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_59_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_59_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_59_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_59_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_62", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_62_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_62_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_62_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx24"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_62_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_62_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_62_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_62_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_62_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_62_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_68", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_68_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_68_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_68_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_68_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_68_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_68_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_68_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_68_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_68_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_69", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_69_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_69_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_69_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_69_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_69_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_69_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_69_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_69_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_69_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_75", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_75_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_75_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_75_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_75_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_75_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_75_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_75_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_75_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_75_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_80", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_80_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_80_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_80_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_80_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_80_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_80_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_80_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_80_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_80_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_83", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_83_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_83_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_83_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_83_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_83_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_83_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_83_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_83_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_83_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_96", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_96_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_96_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_96_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_96_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_96_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_96_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_96_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_96_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_96_property_name_idx"
  end

  create_table "impressions_2018_11_advertiser_98", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_11_advertiser_98_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_11_advertiser_98_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_11_advertiser_98_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_11_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_11_advertiser_98_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_11_advertiser_98_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_11_advertiser_98_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_11_advertiser_98_payable_idx"
    t.index ["property_id"], name: "impressions_2018_11_advertiser_98_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_11_advertiser_98_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_11", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_11_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_11_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_11_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser__campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_11_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_11_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_11_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_11_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_11_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_11_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_13", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_13_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_13_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_13_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx12"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_13_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_13_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_13_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_13_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_13_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_13_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_20", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_20_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_20_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_20_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx16"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_20_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_20_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_20_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_20_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_20_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_20_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_23", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_23_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_23_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_23_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx1"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_23_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_23_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_23_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_23_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_23_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_23_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_28", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_28_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_28_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_28_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx18"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_28_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_28_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_28_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_28_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_28_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_28_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_29", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_29_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_29_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_29_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx3"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_29_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_29_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_29_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_29_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_29_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_29_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_3", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_3_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_3_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_3_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx17"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_3_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_3_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_3_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_3_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_3_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_3_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_34", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_34_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_34_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_34_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx13"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_34_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_34_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_34_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_34_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_34_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_34_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_37", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_37_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_37_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_37_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx20"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_37_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_37_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_37_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_37_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_37_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_37_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_40", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_40_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_40_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_40_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx2"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_40_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_40_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_40_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_40_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_40_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_40_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_43", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_43_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_43_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_43_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx15"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_43_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_43_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_43_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_43_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_43_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_43_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_45", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_45_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_45_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_45_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx14"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_45_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_45_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_45_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_45_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_45_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_45_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_47", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_47_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_47_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_47_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx8"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_47_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_47_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_47_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_47_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_47_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_47_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_57", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_57_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_57_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_57_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx11"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_57_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_57_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_57_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_57_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_57_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_57_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_68", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_68_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_68_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_68_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx5"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_68_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_68_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_68_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_68_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_68_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_68_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_69", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_69_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_69_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_69_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx10"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_69_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_69_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_69_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_69_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_69_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_69_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_75", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_75_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_75_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_75_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx7"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_75_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_75_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_75_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_75_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_75_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_75_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_80", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_80_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_80_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_80_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertise_campaign_name_property_name_idx19"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_80_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_80_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_80_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_80_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_80_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_80_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_82", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_82_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_82_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_82_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx9"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_82_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_82_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_82_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_82_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_82_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_82_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_95", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_95_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_95_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_95_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx6"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_95_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_95_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_95_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_95_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_95_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_95_property_name_idx"
  end

  create_table "impressions_2018_12_advertiser_98", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_2018_12_advertiser_98_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_2018_12_advertiser_98_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_2018_12_advertiser_98_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_2018_12_advertiser_campaign_name_property_name_idx4"
    t.index ["campaign_name"], name: "impressions_2018_12_advertiser_98_campaign_name_idx"
    t.index ["country_code"], name: "impressions_2018_12_advertiser_98_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_2018_12_advertiser_98_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_2018_12_advertiser_98_payable_idx"
    t.index ["property_id"], name: "impressions_2018_12_advertiser_98_property_id_idx"
    t.index ["property_name"], name: "impressions_2018_12_advertiser_98_property_name_idx"
  end

  create_table "impressions_default", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "campaign_id", null: false
    t.string "campaign_name", null: false
    t.bigint "property_id", null: false
    t.string "property_name", null: false
    t.string "ip", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "payable", default: false, null: false
    t.string "reason"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.boolean "fallback_campaign", default: false, null: false
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_default_date_trunc_idx"
    t.index ["advertiser_id"], name: "impressions_default_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_default_campaign_id_idx"
    t.index ["campaign_name", "property_name"], name: "impressions_default_campaign_name_property_name_idx"
    t.index ["campaign_name"], name: "impressions_default_campaign_name_idx"
    t.index ["country_code"], name: "impressions_default_country_code_idx"
    t.index ["displayed_at_date"], name: "impressions_default_displayed_at_date_idx"
    t.index ["payable"], name: "impressions_default_payable_idx"
    t.index ["property_id"], name: "impressions_default_property_id_idx"
    t.index ["property_name"], name: "impressions_default_property_name_idx"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "property_type", null: false
    t.string "status", null: false
    t.string "name", null: false
    t.text "description"
    t.text "url", null: false
    t.string "ad_template"
    t.string "ad_theme"
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

  create_table "property_advertisers", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "advertiser_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advertiser_id"], name: "index_property_advertisers_on_advertiser_id"
    t.index ["property_id", "advertiser_id"], name: "index_property_advertisers_on_property_id_and_advertiser_id", unique: true
    t.index ["property_id"], name: "index_property_advertisers_on_property_id"
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
    t.text "skills", default: [], array: true
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "company_name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "region"
    t.string "postal_code"
    t.string "country"
    t.boolean "us_resident", default: false
    t.boolean "api_access", default: false, null: false
    t.string "api_key"
    t.text "bio"
    t.string "website_url"
    t.string "github_username"
    t.string "twitter_username"
    t.string "linkedin_username"
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
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_users_on_email", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
