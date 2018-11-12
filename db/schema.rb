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

  create_table "impressions_008f8c2", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_008f8c2_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_008f8c2_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_008f8c2_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_008f8c2_on_payable"
    t.index ["property_id"], name: "index_impressions_008f8c2_on_property_id"
  end

  create_table "impressions_00afa31", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_00afa31_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_00afa31_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_00afa31_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_00afa31_on_payable"
    t.index ["property_id"], name: "index_impressions_00afa31_on_property_id"
  end

  create_table "impressions_0281a27", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_0281a27_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_0281a27_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_0281a27_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_0281a27_on_payable"
    t.index ["property_id"], name: "index_impressions_0281a27_on_property_id"
  end

  create_table "impressions_081c4ce", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_081c4ce_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_081c4ce_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_081c4ce_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_081c4ce_on_payable"
    t.index ["property_id"], name: "index_impressions_081c4ce_on_property_id"
  end

  create_table "impressions_0947ece", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_0947ece_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_0947ece_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_0947ece_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_0947ece_on_payable"
    t.index ["property_id"], name: "index_impressions_0947ece_on_property_id"
  end

  create_table "impressions_0a989dc", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_0a989dc_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_0a989dc_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_0a989dc_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_0a989dc_on_payable"
    t.index ["property_id"], name: "index_impressions_0a989dc_on_property_id"
  end

  create_table "impressions_0ae566a", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_0ae566a_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_0ae566a_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_0ae566a_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_0ae566a_on_payable"
    t.index ["property_id"], name: "index_impressions_0ae566a_on_property_id"
  end

  create_table "impressions_0bf3fae", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_0bf3fae_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_0bf3fae_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_0bf3fae_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_0bf3fae_on_payable"
    t.index ["property_id"], name: "index_impressions_0bf3fae_on_property_id"
  end

  create_table "impressions_0fbc017", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_0fbc017_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_0fbc017_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_0fbc017_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_0fbc017_on_payable"
    t.index ["property_id"], name: "index_impressions_0fbc017_on_property_id"
  end

  create_table "impressions_132f3f5", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_132f3f5_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_132f3f5_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_132f3f5_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_132f3f5_on_payable"
    t.index ["property_id"], name: "index_impressions_132f3f5_on_property_id"
  end

  create_table "impressions_155e200", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_155e200_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_155e200_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_155e200_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_155e200_on_payable"
    t.index ["property_id"], name: "index_impressions_155e200_on_property_id"
  end

  create_table "impressions_1c56374", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_1c56374_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_1c56374_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_1c56374_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_1c56374_on_payable"
    t.index ["property_id"], name: "index_impressions_1c56374_on_property_id"
  end

  create_table "impressions_1e4146f", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_1e4146f_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_1e4146f_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_1e4146f_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_1e4146f_on_payable"
    t.index ["property_id"], name: "index_impressions_1e4146f_on_property_id"
  end

  create_table "impressions_26d04a3", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_26d04a3_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_26d04a3_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_26d04a3_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_26d04a3_on_payable"
    t.index ["property_id"], name: "index_impressions_26d04a3_on_property_id"
  end

  create_table "impressions_27d985f", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_27d985f_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_27d985f_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_27d985f_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_27d985f_on_payable"
    t.index ["property_id"], name: "index_impressions_27d985f_on_property_id"
  end

  create_table "impressions_299ed5e", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_299ed5e_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_299ed5e_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_299ed5e_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_299ed5e_on_payable"
    t.index ["property_id"], name: "index_impressions_299ed5e_on_property_id"
  end

  create_table "impressions_2da957d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2da957d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2da957d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2da957d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2da957d_on_payable"
    t.index ["property_id"], name: "index_impressions_2da957d_on_property_id"
  end

  create_table "impressions_2ddf121", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2ddf121_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2ddf121_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2ddf121_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2ddf121_on_payable"
    t.index ["property_id"], name: "index_impressions_2ddf121_on_property_id"
  end

  create_table "impressions_2ede6f8", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_2ede6f8_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_2ede6f8_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_2ede6f8_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_2ede6f8_on_payable"
    t.index ["property_id"], name: "index_impressions_2ede6f8_on_property_id"
  end

  create_table "impressions_318d9ee", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_318d9ee_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_318d9ee_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_318d9ee_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_318d9ee_on_payable"
    t.index ["property_id"], name: "index_impressions_318d9ee_on_property_id"
  end

  create_table "impressions_33e0986", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_33e0986_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_33e0986_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_33e0986_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_33e0986_on_payable"
    t.index ["property_id"], name: "index_impressions_33e0986_on_property_id"
  end

  create_table "impressions_36cd868", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_36cd868_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_36cd868_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_36cd868_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_36cd868_on_payable"
    t.index ["property_id"], name: "index_impressions_36cd868_on_property_id"
  end

  create_table "impressions_3b83f44", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_3b83f44_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_3b83f44_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_3b83f44_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_3b83f44_on_payable"
    t.index ["property_id"], name: "index_impressions_3b83f44_on_property_id"
  end

  create_table "impressions_3bb672d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_3bb672d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_3bb672d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_3bb672d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_3bb672d_on_payable"
    t.index ["property_id"], name: "index_impressions_3bb672d_on_property_id"
  end

  create_table "impressions_3c19367", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_3c19367_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_3c19367_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_3c19367_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_3c19367_on_payable"
    t.index ["property_id"], name: "index_impressions_3c19367_on_property_id"
  end

  create_table "impressions_3d6d9e3", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_3d6d9e3_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_3d6d9e3_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_3d6d9e3_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_3d6d9e3_on_payable"
    t.index ["property_id"], name: "index_impressions_3d6d9e3_on_property_id"
  end

  create_table "impressions_3ed5b0d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_3ed5b0d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_3ed5b0d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_3ed5b0d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_3ed5b0d_on_payable"
    t.index ["property_id"], name: "index_impressions_3ed5b0d_on_property_id"
  end

  create_table "impressions_40d9aec", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_40d9aec_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_40d9aec_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_40d9aec_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_40d9aec_on_payable"
    t.index ["property_id"], name: "index_impressions_40d9aec_on_property_id"
  end

  create_table "impressions_42e511b", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_42e511b_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_42e511b_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_42e511b_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_42e511b_on_payable"
    t.index ["property_id"], name: "index_impressions_42e511b_on_property_id"
  end

  create_table "impressions_49c6760", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_49c6760_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_49c6760_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_49c6760_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_49c6760_on_payable"
    t.index ["property_id"], name: "index_impressions_49c6760_on_property_id"
  end

  create_table "impressions_4afe466", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_4afe466_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_4afe466_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_4afe466_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_4afe466_on_payable"
    t.index ["property_id"], name: "index_impressions_4afe466_on_property_id"
  end

  create_table "impressions_4dd4269", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_4dd4269_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_4dd4269_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_4dd4269_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_4dd4269_on_payable"
    t.index ["property_id"], name: "index_impressions_4dd4269_on_property_id"
  end

  create_table "impressions_4ef837c", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_4ef837c_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_4ef837c_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_4ef837c_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_4ef837c_on_payable"
    t.index ["property_id"], name: "index_impressions_4ef837c_on_property_id"
  end

  create_table "impressions_4f55d86", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_4f55d86_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_4f55d86_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_4f55d86_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_4f55d86_on_payable"
    t.index ["property_id"], name: "index_impressions_4f55d86_on_property_id"
  end

  create_table "impressions_51233a7", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_51233a7_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_51233a7_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_51233a7_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_51233a7_on_payable"
    t.index ["property_id"], name: "index_impressions_51233a7_on_property_id"
  end

  create_table "impressions_522745d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_522745d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_522745d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_522745d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_522745d_on_payable"
    t.index ["property_id"], name: "index_impressions_522745d_on_property_id"
  end

  create_table "impressions_548979a", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_548979a_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_548979a_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_548979a_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_548979a_on_payable"
    t.index ["property_id"], name: "index_impressions_548979a_on_property_id"
  end

  create_table "impressions_5576a2c", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_5576a2c_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_5576a2c_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_5576a2c_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_5576a2c_on_payable"
    t.index ["property_id"], name: "index_impressions_5576a2c_on_property_id"
  end

  create_table "impressions_579ba19", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_579ba19_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_579ba19_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_579ba19_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_579ba19_on_payable"
    t.index ["property_id"], name: "index_impressions_579ba19_on_property_id"
  end

  create_table "impressions_591d6f9", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_591d6f9_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_591d6f9_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_591d6f9_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_591d6f9_on_payable"
    t.index ["property_id"], name: "index_impressions_591d6f9_on_property_id"
  end

  create_table "impressions_5ad7ce6", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_5ad7ce6_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_5ad7ce6_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_5ad7ce6_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_5ad7ce6_on_payable"
    t.index ["property_id"], name: "index_impressions_5ad7ce6_on_property_id"
  end

  create_table "impressions_5b275aa", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_5b275aa_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_5b275aa_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_5b275aa_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_5b275aa_on_payable"
    t.index ["property_id"], name: "index_impressions_5b275aa_on_property_id"
  end

  create_table "impressions_5c24c1f", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_5c24c1f_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_5c24c1f_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_5c24c1f_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_5c24c1f_on_payable"
    t.index ["property_id"], name: "index_impressions_5c24c1f_on_property_id"
  end

  create_table "impressions_5e64735", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_5e64735_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_5e64735_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_5e64735_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_5e64735_on_payable"
    t.index ["property_id"], name: "index_impressions_5e64735_on_property_id"
  end

  create_table "impressions_6025363", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_6025363_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_6025363_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_6025363_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_6025363_on_payable"
    t.index ["property_id"], name: "index_impressions_6025363_on_property_id"
  end

  create_table "impressions_6707fb6", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_6707fb6_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_6707fb6_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_6707fb6_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_6707fb6_on_payable"
    t.index ["property_id"], name: "index_impressions_6707fb6_on_property_id"
  end

  create_table "impressions_67312bc", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_67312bc_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_67312bc_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_67312bc_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_67312bc_on_payable"
    t.index ["property_id"], name: "index_impressions_67312bc_on_property_id"
  end

  create_table "impressions_6917f25", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_6917f25_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_6917f25_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_6917f25_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_6917f25_on_payable"
    t.index ["property_id"], name: "index_impressions_6917f25_on_property_id"
  end

  create_table "impressions_6e55f42", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_6e55f42_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_6e55f42_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_6e55f42_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_6e55f42_on_payable"
    t.index ["property_id"], name: "index_impressions_6e55f42_on_property_id"
  end

  create_table "impressions_7056f65", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_7056f65_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_7056f65_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_7056f65_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_7056f65_on_payable"
    t.index ["property_id"], name: "index_impressions_7056f65_on_property_id"
  end

  create_table "impressions_74c0c78", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_74c0c78_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_74c0c78_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_74c0c78_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_74c0c78_on_payable"
    t.index ["property_id"], name: "index_impressions_74c0c78_on_property_id"
  end

  create_table "impressions_78e11c5", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_78e11c5_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_78e11c5_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_78e11c5_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_78e11c5_on_payable"
    t.index ["property_id"], name: "index_impressions_78e11c5_on_property_id"
  end

  create_table "impressions_7b5e867", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_7b5e867_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_7b5e867_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_7b5e867_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_7b5e867_on_payable"
    t.index ["property_id"], name: "index_impressions_7b5e867_on_property_id"
  end

  create_table "impressions_7e8ebd6", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_7e8ebd6_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_7e8ebd6_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_7e8ebd6_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_7e8ebd6_on_payable"
    t.index ["property_id"], name: "index_impressions_7e8ebd6_on_property_id"
  end

  create_table "impressions_7ebab1d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_7ebab1d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_7ebab1d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_7ebab1d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_7ebab1d_on_payable"
    t.index ["property_id"], name: "index_impressions_7ebab1d_on_property_id"
  end

  create_table "impressions_7f04b7c", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_7f04b7c_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_7f04b7c_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_7f04b7c_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_7f04b7c_on_payable"
    t.index ["property_id"], name: "index_impressions_7f04b7c_on_property_id"
  end

  create_table "impressions_7f556bf", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_7f556bf_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_7f556bf_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_7f556bf_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_7f556bf_on_payable"
    t.index ["property_id"], name: "index_impressions_7f556bf_on_property_id"
  end

  create_table "impressions_80a90da", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_80a90da_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_80a90da_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_80a90da_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_80a90da_on_payable"
    t.index ["property_id"], name: "index_impressions_80a90da_on_property_id"
  end

  create_table "impressions_8142edc", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8142edc_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8142edc_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8142edc_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8142edc_on_payable"
    t.index ["property_id"], name: "index_impressions_8142edc_on_property_id"
  end

  create_table "impressions_8474984", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8474984_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8474984_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8474984_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8474984_on_payable"
    t.index ["property_id"], name: "index_impressions_8474984_on_property_id"
  end

  create_table "impressions_85f5e29", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_85f5e29_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_85f5e29_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_85f5e29_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_85f5e29_on_payable"
    t.index ["property_id"], name: "index_impressions_85f5e29_on_property_id"
  end

  create_table "impressions_862d332", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_862d332_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_862d332_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_862d332_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_862d332_on_payable"
    t.index ["property_id"], name: "index_impressions_862d332_on_property_id"
  end

  create_table "impressions_8894562", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8894562_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8894562_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8894562_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8894562_on_payable"
    t.index ["property_id"], name: "index_impressions_8894562_on_property_id"
  end

  create_table "impressions_8a205c2", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8a205c2_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8a205c2_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8a205c2_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8a205c2_on_payable"
    t.index ["property_id"], name: "index_impressions_8a205c2_on_property_id"
  end

  create_table "impressions_8c4dd57", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8c4dd57_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8c4dd57_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8c4dd57_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8c4dd57_on_payable"
    t.index ["property_id"], name: "index_impressions_8c4dd57_on_property_id"
  end

  create_table "impressions_8cf9e1c", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8cf9e1c_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8cf9e1c_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8cf9e1c_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8cf9e1c_on_payable"
    t.index ["property_id"], name: "index_impressions_8cf9e1c_on_property_id"
  end

  create_table "impressions_8e2ff6b", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_8e2ff6b_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_8e2ff6b_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_8e2ff6b_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_8e2ff6b_on_payable"
    t.index ["property_id"], name: "index_impressions_8e2ff6b_on_property_id"
  end

  create_table "impressions_9025cbb", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_9025cbb_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_9025cbb_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_9025cbb_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_9025cbb_on_payable"
    t.index ["property_id"], name: "index_impressions_9025cbb_on_property_id"
  end

  create_table "impressions_90d9302", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_90d9302_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_90d9302_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_90d9302_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_90d9302_on_payable"
    t.index ["property_id"], name: "index_impressions_90d9302_on_property_id"
  end

  create_table "impressions_9257c9d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_9257c9d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_9257c9d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_9257c9d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_9257c9d_on_payable"
    t.index ["property_id"], name: "index_impressions_9257c9d_on_property_id"
  end

  create_table "impressions_93d7d18", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_93d7d18_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_93d7d18_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_93d7d18_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_93d7d18_on_payable"
    t.index ["property_id"], name: "index_impressions_93d7d18_on_property_id"
  end

  create_table "impressions_94f0a87", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_94f0a87_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_94f0a87_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_94f0a87_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_94f0a87_on_payable"
    t.index ["property_id"], name: "index_impressions_94f0a87_on_property_id"
  end

  create_table "impressions_95c00de", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_95c00de_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_95c00de_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_95c00de_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_95c00de_on_payable"
    t.index ["property_id"], name: "index_impressions_95c00de_on_property_id"
  end

  create_table "impressions_95f5aed", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_95f5aed_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_95f5aed_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_95f5aed_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_95f5aed_on_payable"
    t.index ["property_id"], name: "index_impressions_95f5aed_on_property_id"
  end

  create_table "impressions_977ed92", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_977ed92_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_977ed92_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_977ed92_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_977ed92_on_payable"
    t.index ["property_id"], name: "index_impressions_977ed92_on_property_id"
  end

  create_table "impressions_99bd6ac", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_99bd6ac_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_99bd6ac_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_99bd6ac_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_99bd6ac_on_payable"
    t.index ["property_id"], name: "index_impressions_99bd6ac_on_property_id"
  end

  create_table "impressions_9d02901", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_9d02901_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_9d02901_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_9d02901_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_9d02901_on_payable"
    t.index ["property_id"], name: "index_impressions_9d02901_on_property_id"
  end

  create_table "impressions_a5b36a9", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_a5b36a9_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_a5b36a9_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_a5b36a9_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_a5b36a9_on_payable"
    t.index ["property_id"], name: "index_impressions_a5b36a9_on_property_id"
  end

  create_table "impressions_a5d876d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_a5d876d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_a5d876d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_a5d876d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_a5d876d_on_payable"
    t.index ["property_id"], name: "index_impressions_a5d876d_on_property_id"
  end

  create_table "impressions_a6e5a50", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_a6e5a50_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_a6e5a50_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_a6e5a50_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_a6e5a50_on_payable"
    t.index ["property_id"], name: "index_impressions_a6e5a50_on_property_id"
  end

  create_table "impressions_a7f178b", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_a7f178b_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_a7f178b_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_a7f178b_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_a7f178b_on_payable"
    t.index ["property_id"], name: "index_impressions_a7f178b_on_property_id"
  end

  create_table "impressions_accf3ae", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_accf3ae_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_accf3ae_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_accf3ae_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_accf3ae_on_payable"
    t.index ["property_id"], name: "index_impressions_accf3ae_on_property_id"
  end

  create_table "impressions_ad1667d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_ad1667d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_ad1667d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_ad1667d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_ad1667d_on_payable"
    t.index ["property_id"], name: "index_impressions_ad1667d_on_property_id"
  end

  create_table "impressions_adab992", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_adab992_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_adab992_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_adab992_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_adab992_on_payable"
    t.index ["property_id"], name: "index_impressions_adab992_on_property_id"
  end

  create_table "impressions_af29709", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_af29709_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_af29709_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_af29709_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_af29709_on_payable"
    t.index ["property_id"], name: "index_impressions_af29709_on_property_id"
  end

  create_table "impressions_b30c5f4", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_b30c5f4_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_b30c5f4_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_b30c5f4_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_b30c5f4_on_payable"
    t.index ["property_id"], name: "index_impressions_b30c5f4_on_property_id"
  end

  create_table "impressions_b8b32d6", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_b8b32d6_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_b8b32d6_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_b8b32d6_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_b8b32d6_on_payable"
    t.index ["property_id"], name: "index_impressions_b8b32d6_on_property_id"
  end

  create_table "impressions_b9feea5", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_b9feea5_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_b9feea5_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_b9feea5_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_b9feea5_on_payable"
    t.index ["property_id"], name: "index_impressions_b9feea5_on_property_id"
  end

  create_table "impressions_bc32520", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_bc32520_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_bc32520_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_bc32520_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_bc32520_on_payable"
    t.index ["property_id"], name: "index_impressions_bc32520_on_property_id"
  end

  create_table "impressions_be31132", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_be31132_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_be31132_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_be31132_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_be31132_on_payable"
    t.index ["property_id"], name: "index_impressions_be31132_on_property_id"
  end

  create_table "impressions_c14ec8a", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_c14ec8a_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_c14ec8a_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_c14ec8a_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_c14ec8a_on_payable"
    t.index ["property_id"], name: "index_impressions_c14ec8a_on_property_id"
  end

  create_table "impressions_c3037b2", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_c3037b2_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_c3037b2_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_c3037b2_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_c3037b2_on_payable"
    t.index ["property_id"], name: "index_impressions_c3037b2_on_property_id"
  end

  create_table "impressions_c4350d3", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_c4350d3_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_c4350d3_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_c4350d3_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_c4350d3_on_payable"
    t.index ["property_id"], name: "index_impressions_c4350d3_on_property_id"
  end

  create_table "impressions_c9cb65e", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_c9cb65e_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_c9cb65e_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_c9cb65e_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_c9cb65e_on_payable"
    t.index ["property_id"], name: "index_impressions_c9cb65e_on_property_id"
  end

  create_table "impressions_cb5be27", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_cb5be27_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_cb5be27_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_cb5be27_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_cb5be27_on_payable"
    t.index ["property_id"], name: "index_impressions_cb5be27_on_property_id"
  end

  create_table "impressions_cc3bbc2", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_cc3bbc2_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_cc3bbc2_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_cc3bbc2_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_cc3bbc2_on_payable"
    t.index ["property_id"], name: "index_impressions_cc3bbc2_on_property_id"
  end

  create_table "impressions_ccfc39a", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_ccfc39a_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_ccfc39a_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_ccfc39a_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_ccfc39a_on_payable"
    t.index ["property_id"], name: "index_impressions_ccfc39a_on_property_id"
  end

  create_table "impressions_d072121", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_d072121_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_d072121_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_d072121_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_d072121_on_payable"
    t.index ["property_id"], name: "index_impressions_d072121_on_property_id"
  end

  create_table "impressions_d2b5f35", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_d2b5f35_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_d2b5f35_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_d2b5f35_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_d2b5f35_on_payable"
    t.index ["property_id"], name: "index_impressions_d2b5f35_on_property_id"
  end

  create_table "impressions_d500d91", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_d500d91_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_d500d91_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_d500d91_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_d500d91_on_payable"
    t.index ["property_id"], name: "index_impressions_d500d91_on_property_id"
  end

  create_table "impressions_d801546", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_d801546_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_d801546_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_d801546_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_d801546_on_payable"
    t.index ["property_id"], name: "index_impressions_d801546_on_property_id"
  end

  create_table "impressions_d9f318d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_d9f318d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_d9f318d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_d9f318d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_d9f318d_on_payable"
    t.index ["property_id"], name: "index_impressions_d9f318d_on_property_id"
  end

  create_table "impressions_db5c100", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_db5c100_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_db5c100_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_db5c100_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_db5c100_on_payable"
    t.index ["property_id"], name: "index_impressions_db5c100_on_property_id"
  end

  create_table "impressions_dbfada5", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_dbfada5_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_dbfada5_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_dbfada5_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_dbfada5_on_payable"
    t.index ["property_id"], name: "index_impressions_dbfada5_on_property_id"
  end

  create_table "impressions_dcfa592", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_dcfa592_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_dcfa592_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_dcfa592_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_dcfa592_on_payable"
    t.index ["property_id"], name: "index_impressions_dcfa592_on_property_id"
  end

  create_table "impressions_e0da3fd", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_e0da3fd_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_e0da3fd_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_e0da3fd_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_e0da3fd_on_payable"
    t.index ["property_id"], name: "index_impressions_e0da3fd_on_property_id"
  end

  create_table "impressions_e6bd22d", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_e6bd22d_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_e6bd22d_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_e6bd22d_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_e6bd22d_on_payable"
    t.index ["property_id"], name: "index_impressions_e6bd22d_on_property_id"
  end

  create_table "impressions_e7cdbb8", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_e7cdbb8_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_e7cdbb8_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_e7cdbb8_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_e7cdbb8_on_payable"
    t.index ["property_id"], name: "index_impressions_e7cdbb8_on_property_id"
  end

  create_table "impressions_e7f326c", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_e7f326c_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_e7f326c_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_e7f326c_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_e7f326c_on_payable"
    t.index ["property_id"], name: "index_impressions_e7f326c_on_property_id"
  end

  create_table "impressions_e942689", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_e942689_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_e942689_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_e942689_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_e942689_on_payable"
    t.index ["property_id"], name: "index_impressions_e942689_on_property_id"
  end

  create_table "impressions_eb6cfa6", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_eb6cfa6_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_eb6cfa6_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_eb6cfa6_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_eb6cfa6_on_payable"
    t.index ["property_id"], name: "index_impressions_eb6cfa6_on_property_id"
  end

  create_table "impressions_ec2dc1e", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_ec2dc1e_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_ec2dc1e_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_ec2dc1e_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_ec2dc1e_on_payable"
    t.index ["property_id"], name: "index_impressions_ec2dc1e_on_property_id"
  end

  create_table "impressions_efc15cd", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_efc15cd_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_efc15cd_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_efc15cd_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_efc15cd_on_payable"
    t.index ["property_id"], name: "index_impressions_efc15cd_on_property_id"
  end

  create_table "impressions_f03d063", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_f03d063_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_f03d063_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_f03d063_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_f03d063_on_payable"
    t.index ["property_id"], name: "index_impressions_f03d063_on_property_id"
  end

  create_table "impressions_f1cbe01", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_f1cbe01_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_f1cbe01_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_f1cbe01_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_f1cbe01_on_payable"
    t.index ["property_id"], name: "index_impressions_f1cbe01_on_property_id"
  end

  create_table "impressions_f2d2cd3", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_f2d2cd3_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_f2d2cd3_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_f2d2cd3_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_f2d2cd3_on_payable"
    t.index ["property_id"], name: "index_impressions_f2d2cd3_on_property_id"
  end

  create_table "impressions_f2f396a", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_f2f396a_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_f2f396a_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_f2f396a_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_f2f396a_on_payable"
    t.index ["property_id"], name: "index_impressions_f2f396a_on_property_id"
  end

  create_table "impressions_f5a1145", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_f5a1145_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_f5a1145_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_f5a1145_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_f5a1145_on_payable"
    t.index ["property_id"], name: "index_impressions_f5a1145_on_property_id"
  end

  create_table "impressions_f66d3ce", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_f66d3ce_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_f66d3ce_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_f66d3ce_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_f66d3ce_on_payable"
    t.index ["property_id"], name: "index_impressions_f66d3ce_on_property_id"
  end

  create_table "impressions_fbcea0f", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "property_id"
    t.string "ip"
    t.text "user_agent"
    t.string "country"
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
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_fbcea0f_on_displayed_at_hour"
    t.index ["campaign_id"], name: "index_impressions_fbcea0f_on_campaign_id"
    t.index ["displayed_at_date"], name: "index_impressions_fbcea0f_on_displayed_at_date"
    t.index ["payable"], name: "index_impressions_fbcea0f_on_payable"
    t.index ["property_id"], name: "index_impressions_fbcea0f_on_property_id"
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
