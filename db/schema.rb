# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_28_141603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "tablefunc"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "campaign_bundles", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.bigint "region_ids", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((name)::text)", name: "index_campaign_bundles_on_name"
    t.index ["end_date"], name: "index_campaign_bundles_on_end_date"
    t.index ["region_ids"], name: "index_campaign_bundles_on_region_ids", using: :gin
    t.index ["start_date"], name: "index_campaign_bundles_on_start_date"
  end

  create_table "campaigns", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "creative_id"
    t.string "status", null: false
    t.boolean "fallback", default: false, null: false
    t.string "name", null: false
    t.text "url", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.boolean "core_hours_only", default: false
    t.boolean "weekdays_only", default: false
    t.integer "total_budget_cents", default: 0, null: false
    t.string "total_budget_currency", default: "USD", null: false
    t.integer "daily_budget_cents", default: 0, null: false
    t.string "daily_budget_currency", default: "USD", null: false
    t.integer "ecpm_cents", default: 0, null: false
    t.string "ecpm_currency", default: "USD", null: false
    t.string "country_codes", default: [], array: true
    t.string "keywords", default: [], array: true
    t.string "negative_keywords", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "legacy_id"
    t.bigint "organization_id"
    t.boolean "job_posting", default: false, null: false
    t.string "province_codes", default: [], array: true
    t.boolean "fixed_ecpm", default: true, null: false
    t.bigint "assigned_property_ids", default: [], null: false, array: true
    t.integer "hourly_budget_cents", default: 0, null: false
    t.string "hourly_budget_currency", default: "USD", null: false
    t.bigint "prohibited_property_ids", default: [], null: false, array: true
    t.bigint "creative_ids", default: [], null: false, array: true
    t.boolean "paid_fallback", default: false
    t.bigint "campaign_bundle_id"
    t.bigint "audience_ids", default: [], null: false, array: true
    t.bigint "region_ids", default: [], null: false, array: true
    t.decimal "ecpm_multiplier", default: "1.0", null: false
    t.index "lower((name)::text)", name: "index_campaigns_on_name"
    t.index ["assigned_property_ids"], name: "index_campaigns_on_assigned_property_ids", using: :gin
    t.index ["audience_ids"], name: "index_campaigns_on_audience_ids", using: :gin
    t.index ["campaign_bundle_id"], name: "index_campaigns_on_campaign_bundle_id"
    t.index ["core_hours_only"], name: "index_campaigns_on_core_hours_only"
    t.index ["country_codes"], name: "index_campaigns_on_country_codes", using: :gin
    t.index ["creative_id"], name: "index_campaigns_on_creative_id"
    t.index ["creative_ids"], name: "index_campaigns_on_creative_ids", using: :gin
    t.index ["end_date"], name: "index_campaigns_on_end_date"
    t.index ["job_posting"], name: "index_campaigns_on_job_posting"
    t.index ["keywords"], name: "index_campaigns_on_keywords", using: :gin
    t.index ["negative_keywords"], name: "index_campaigns_on_negative_keywords", using: :gin
    t.index ["organization_id"], name: "index_campaigns_on_organization_id"
    t.index ["paid_fallback"], name: "index_campaigns_on_paid_fallback"
    t.index ["prohibited_property_ids"], name: "index_campaigns_on_prohibited_property_ids", using: :gin
    t.index ["province_codes"], name: "index_campaigns_on_province_codes", using: :gin
    t.index ["region_ids"], name: "index_campaigns_on_region_ids", using: :gin
    t.index ["start_date"], name: "index_campaigns_on_start_date"
    t.index ["status"], name: "index_campaigns_on_status"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
    t.index ["weekdays_only"], name: "index_campaigns_on_weekdays_only"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.bigint "user_id", null: false
    t.bigint "parent_id"
    t.bigint "lft"
    t.bigint "rgt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.string "coupon_type", null: false
    t.integer "discount_percent", default: 0, null: false
    t.datetime "expires_at", null: false
    t.integer "quantity", default: 99999, null: false
    t.integer "claimed", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_coupons_on_code", unique: true
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
    t.string "headline"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "legacy_id"
    t.bigint "organization_id"
    t.string "cta"
    t.string "status", default: "pending"
    t.string "creative_type", default: "standard", null: false
    t.index ["creative_type"], name: "index_creatives_on_creative_type"
    t.index ["organization_id"], name: "index_creatives_on_organization_id"
    t.index ["user_id"], name: "index_creatives_on_user_id"
  end

  create_table "daily_summaries", force: :cascade do |t|
    t.string "impressionable_type", null: false
    t.bigint "impressionable_id", null: false
    t.string "scoped_by_type"
    t.string "scoped_by_id"
    t.integer "impressions_count", default: 0, null: false
    t.integer "fallbacks_count", default: 0, null: false
    t.decimal "fallback_percentage", default: "0.0", null: false
    t.integer "clicks_count", default: 0, null: false
    t.decimal "click_rate", default: "0.0", null: false
    t.integer "ecpm_cents", default: 0, null: false
    t.string "ecpm_currency", default: "USD", null: false
    t.integer "cost_per_click_cents", default: 0, null: false
    t.string "cost_per_click_currency", default: "USD", null: false
    t.integer "gross_revenue_cents", default: 0, null: false
    t.string "gross_revenue_currency", default: "USD", null: false
    t.integer "property_revenue_cents", default: 0, null: false
    t.string "property_revenue_currency", default: "USD", null: false
    t.integer "house_revenue_cents", default: 0, null: false
    t.string "house_revenue_currency", default: "USD", null: false
    t.date "displayed_at_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unique_ip_addresses_count", default: 0, null: false
    t.bigint "fallback_clicks_count", default: 0, null: false
    t.index ["displayed_at_date"], name: "index_daily_summaries_on_displayed_at_date"
    t.index ["impressionable_type", "impressionable_id", "displayed_at_date"], name: "index_daily_summaries_unscoped_uniqueness", unique: true, where: "((scoped_by_type IS NULL) AND (scoped_by_id IS NULL))"
    t.index ["impressionable_type", "impressionable_id", "scoped_by_type", "scoped_by_id", "displayed_at_date"], name: "index_daily_summaries_uniqueness", unique: true
    t.index ["impressionable_type", "impressionable_id"], name: "index_daily_summaries_on_impressionable_columns"
    t.index ["scoped_by_type", "scoped_by_id"], name: "index_daily_summaries_on_scoped_by_columns"
  end

  create_table "email_hierarchies", id: false, force: :cascade do |t|
    t.bigint "ancestor_id", null: false
    t.bigint "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "email_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "email_desc_idx"
  end

  create_table "email_users", force: :cascade do |t|
    t.bigint "email_id", null: false
    t.bigint "user_id", null: false
    t.datetime "read_at"
    t.index ["email_id", "user_id"], name: "index_email_users_on_email_id_and_user_id", unique: true
  end

  create_table "emails", force: :cascade do |t|
    t.text "body"
    t.datetime "delivered_at", null: false
    t.date "delivered_at_date", null: false
    t.string "recipients", default: [], null: false, array: true
    t.string "sender"
    t.text "snippet"
    t.text "subject"
    t.bigint "action_mailbox_inbound_email_id", null: false
    t.string "direction", default: "inbound", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "in_reply_to"
    t.string "message_id"
    t.bigint "parent_id"
    t.index "date_trunc('hour'::text, delivered_at)", name: "index_emails_on_delivered_at_hour"
    t.index ["delivered_at_date"], name: "index_emails_on_delivered_at_date"
    t.index ["parent_id"], name: "index_emails_on_parent_id"
    t.index ["recipients"], name: "index_emails_on_recipients", using: :gin
    t.index ["sender"], name: "index_emails_on_sender"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "eventable_id", null: false
    t.string "eventable_type", null: false
    t.string "tags", default: [], array: true
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventable_id", "eventable_type"], name: "index_events_on_eventable_id_and_eventable_type"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "impressions", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "publisher_id", null: false
    t.bigint "campaign_id", null: false
    t.bigint "creative_id", null: false
    t.bigint "property_id", null: false
    t.string "ip_address", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.date "clicked_at_date"
    t.boolean "fallback_campaign", default: false, null: false
    t.float "estimated_gross_revenue_fractional_cents"
    t.float "estimated_property_revenue_fractional_cents"
    t.float "estimated_house_revenue_fractional_cents"
    t.string "ad_template"
    t.string "ad_theme"
    t.bigint "organization_id"
    t.string "province_code"
    t.boolean "uplift", default: false
    t.index "date_trunc('hour'::text, clicked_at)", name: "index_impressions_on_clicked_at_hour"
    t.index "date_trunc('hour'::text, displayed_at)", name: "index_impressions_on_displayed_at_hour"
    t.index ["ad_template"], name: "index_impressions_on_ad_template"
    t.index ["ad_theme"], name: "index_impressions_on_ad_theme"
    t.index ["advertiser_id"], name: "index_impressions_on_advertiser_id"
    t.index ["campaign_id"], name: "index_impressions_on_campaign_id"
    t.index ["clicked_at_date"], name: "index_impressions_on_clicked_at_date"
    t.index ["country_code"], name: "index_impressions_on_country_code"
    t.index ["creative_id"], name: "index_impressions_on_creative_id"
    t.index ["displayed_at_date"], name: "index_impressions_on_displayed_at_date"
    t.index ["id", "advertiser_id", "displayed_at_date"], name: "index_impressions_on_id_and_advertiser_id_and_displayed_at_date", unique: true
    t.index ["organization_id"], name: "index_impressions_on_organization_id"
    t.index ["property_id"], name: "index_impressions_on_property_id"
    t.index ["province_code"], name: "index_impressions_on_province_code"
    t.index ["uplift"], name: "index_impressions_on_uplift"
  end

  create_table "impressions_default", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "advertiser_id", null: false
    t.bigint "publisher_id", null: false
    t.bigint "campaign_id", null: false
    t.bigint "creative_id", null: false
    t.bigint "property_id", null: false
    t.string "ip_address", null: false
    t.text "user_agent", null: false
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "displayed_at", null: false
    t.date "displayed_at_date", null: false
    t.datetime "clicked_at"
    t.date "clicked_at_date"
    t.boolean "fallback_campaign", default: false, null: false
    t.float "estimated_gross_revenue_fractional_cents"
    t.float "estimated_property_revenue_fractional_cents"
    t.float "estimated_house_revenue_fractional_cents"
    t.string "ad_template"
    t.string "ad_theme"
    t.bigint "organization_id"
    t.string "province_code"
    t.boolean "uplift", default: false
    t.index "date_trunc('hour'::text, clicked_at)", name: "impressions_default_date_trunc_idx1"
    t.index "date_trunc('hour'::text, displayed_at)", name: "impressions_default_date_trunc_idx"
    t.index ["ad_template"], name: "impressions_default_ad_template_idx"
    t.index ["ad_theme"], name: "impressions_default_ad_theme_idx"
    t.index ["advertiser_id"], name: "impressions_default_advertiser_id_idx"
    t.index ["campaign_id"], name: "impressions_default_campaign_id_idx"
    t.index ["clicked_at_date"], name: "impressions_default_clicked_at_date_idx"
    t.index ["country_code"], name: "impressions_default_country_code_idx"
    t.index ["creative_id"], name: "impressions_default_creative_id_idx"
    t.index ["displayed_at_date"], name: "impressions_default_displayed_at_date_idx"
    t.index ["id", "advertiser_id", "displayed_at_date"], name: "impressions_default_id_advertiser_id_displayed_at_date_idx", unique: true
    t.index ["organization_id"], name: "impressions_default_organization_id_idx"
    t.index ["property_id"], name: "impressions_default_property_id_idx"
    t.index ["province_code"], name: "impressions_default_province_code_idx"
    t.index ["uplift"], name: "impressions_default_uplift_idx"
  end

  create_table "job_postings", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.string "status", default: "pending", null: false
    t.string "source", default: "internal", null: false
    t.string "source_identifier"
    t.string "job_type", null: false
    t.string "company_name"
    t.string "company_url"
    t.string "company_logo_url"
    t.string "title", null: false
    t.text "description", null: false
    t.text "how_to_apply"
    t.string "keywords", default: [], null: false, array: true
    t.boolean "display_salary", default: true
    t.integer "min_annual_salary_cents", default: 0, null: false
    t.string "min_annual_salary_currency", default: "USD", null: false
    t.integer "max_annual_salary_cents", default: 0, null: false
    t.string "max_annual_salary_currency", default: "USD", null: false
    t.boolean "remote", default: false, null: false
    t.string "remote_country_codes", default: [], null: false, array: true
    t.string "city"
    t.string "province_name"
    t.string "province_code"
    t.string "country_code"
    t.text "url"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.tsvector "full_text_search"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_email"
    t.string "stripe_charge_id"
    t.string "session_id"
    t.boolean "auto_renew", default: true, null: false
    t.integer "list_view_count", default: 0, null: false
    t.integer "detail_view_count", default: 0, null: false
    t.bigint "coupon_id"
    t.string "plan"
    t.string "offers", default: [], null: false, array: true
    t.index ["auto_renew"], name: "index_job_postings_on_auto_renew"
    t.index ["campaign_id"], name: "index_job_postings_on_campaign_id"
    t.index ["city"], name: "index_job_postings_on_city"
    t.index ["company_name"], name: "index_job_postings_on_company_name"
    t.index ["country_code"], name: "index_job_postings_on_country_code"
    t.index ["coupon_id"], name: "index_job_postings_on_coupon_id"
    t.index ["detail_view_count"], name: "index_job_postings_on_detail_view_count"
    t.index ["end_date"], name: "index_job_postings_on_end_date"
    t.index ["full_text_search"], name: "index_job_postings_on_full_text_search", using: :gin
    t.index ["job_type"], name: "index_job_postings_on_job_type"
    t.index ["keywords"], name: "index_job_postings_on_keywords", using: :gin
    t.index ["list_view_count"], name: "index_job_postings_on_list_view_count"
    t.index ["max_annual_salary_cents"], name: "index_job_postings_on_max_annual_salary_cents"
    t.index ["min_annual_salary_cents"], name: "index_job_postings_on_min_annual_salary_cents"
    t.index ["offers"], name: "index_job_postings_on_offers", using: :gin
    t.index ["organization_id"], name: "index_job_postings_on_organization_id"
    t.index ["plan"], name: "index_job_postings_on_plan"
    t.index ["province_code"], name: "index_job_postings_on_province_code"
    t.index ["province_name"], name: "index_job_postings_on_province_name"
    t.index ["remote"], name: "index_job_postings_on_remote"
    t.index ["remote_country_codes"], name: "index_job_postings_on_remote_country_codes", using: :gin
    t.index ["session_id"], name: "index_job_postings_on_session_id"
    t.index ["source", "source_identifier"], name: "index_job_postings_on_source_and_source_identifier", unique: true
    t.index ["start_date"], name: "index_job_postings_on_start_date"
    t.index ["title"], name: "index_job_postings_on_title"
    t.index ["user_id"], name: "index_job_postings_on_user_id"
  end

  create_table "organization_reports", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "title", null: false
    t.string "status", default: "pending", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.text "pdf_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campaign_ids", default: [], null: false, array: true
    t.index ["organization_id"], name: "index_organization_reports_on_organization_id"
  end

  create_table "organization_transactions", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "transaction_type", null: false
    t.datetime "posted_at", null: false
    t.text "description"
    t.text "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "gift", default: false
    t.boolean "temporary", default: false
    t.index ["gift"], name: "index_organization_transactions_on_gift"
    t.index ["organization_id"], name: "index_organization_transactions_on_organization_id"
    t.index ["reference"], name: "index_organization_transactions_on_reference"
    t.index ["transaction_type"], name: "index_organization_transactions_on_transaction_type"
  end

  create_table "organization_users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id", "user_id", "role"], name: "index_organization_users_on_uniqueness", unique: true
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "creative_approval_needed", default: true
    t.bigint "account_manager_user_id"
    t.text "url"
    t.index ["account_manager_user_id"], name: "index_organizations_on_account_manager_user_id"
    t.index ["creative_approval_needed"], name: "index_organizations_on_creative_approval_needed"
  end

  create_table "pixel_conversions", force: :cascade do |t|
    t.uuid "pixel_id", null: false
    t.uuid "impression_id"
    t.string "impression_id_param", default: "", null: false
    t.boolean "test", default: false, null: false
    t.string "pixel_name", default: "", null: false
    t.integer "pixel_value_cents", default: 0, null: false
    t.string "pixel_value_currency", default: "USD", null: false
    t.bigint "advertiser_id"
    t.bigint "publisher_id"
    t.bigint "campaign_id"
    t.bigint "creative_id"
    t.bigint "property_id"
    t.string "ip_address"
    t.text "user_agent"
    t.string "country_code"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "displayed_at"
    t.date "displayed_at_date"
    t.datetime "clicked_at"
    t.date "clicked_at_date"
    t.boolean "fallback_campaign", default: false, null: false
    t.jsonb "metadata", default: "{}", null: false
    t.text "conversion_referrer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["advertiser_id"], name: "index_pixel_conversions_on_advertiser_id"
    t.index ["campaign_id"], name: "index_pixel_conversions_on_campaign_id"
    t.index ["clicked_at_date"], name: "index_pixel_conversions_on_clicked_at_date"
    t.index ["country_code"], name: "index_pixel_conversions_on_country_code"
    t.index ["creative_id"], name: "index_pixel_conversions_on_creative_id"
    t.index ["displayed_at_date"], name: "index_pixel_conversions_on_displayed_at_date"
    t.index ["impression_id"], name: "index_pixel_conversions_on_impression_id"
    t.index ["metadata"], name: "index_pixel_conversions_on_metadata", using: :gin
    t.index ["pixel_id", "impression_id_param"], name: "index_pixel_conversions_on_pixel_id_and_impression_id_param", unique: true
    t.index ["pixel_id"], name: "index_pixel_conversions_on_pixel_id"
    t.index ["property_id"], name: "index_pixel_conversions_on_property_id"
  end

  create_table "pixels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "USD", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_pixels_on_organization_id"
    t.index ["user_id"], name: "index_pixels_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "property_type", default: "website", null: false
    t.string "status", null: false
    t.string "name", null: false
    t.text "description"
    t.text "url", null: false
    t.string "ad_template"
    t.string "ad_theme"
    t.string "language", null: false
    t.string "keywords", default: [], null: false, array: true
    t.boolean "prohibit_fallback_campaigns", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "legacy_id"
    t.decimal "revenue_percentage", default: "0.6", null: false
    t.bigint "assigned_fallback_campaign_ids", default: [], null: false, array: true
    t.boolean "restrict_to_assigner_campaigns", default: false, null: false
    t.string "fallback_ad_template"
    t.string "fallback_ad_theme"
    t.string "responsive_behavior", default: "none", null: false
    t.bigint "audience_id"
    t.datetime "deleted_at"
    t.bigint "prohibited_organization_ids", default: [], null: false, array: true
    t.index "lower((name)::text)", name: "index_properties_on_name"
    t.index ["assigned_fallback_campaign_ids"], name: "index_properties_on_assigned_fallback_campaign_ids", using: :gin
    t.index ["audience_id"], name: "index_properties_on_audience_id"
    t.index ["keywords"], name: "index_properties_on_keywords", using: :gin
    t.index ["prohibited_organization_ids"], name: "index_properties_on_prohibited_organization_ids", using: :gin
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

  create_table "property_traffic_estimates", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "site_worth_cents", default: 0, null: false
    t.string "site_worth_currency", default: "USD", null: false
    t.bigint "visitors_daily", default: 0
    t.bigint "visitors_monthly", default: 0
    t.bigint "visitors_yearly", default: 0
    t.bigint "pageviews_daily", default: 0
    t.bigint "pageviews_monthly", default: 0
    t.bigint "pageviews_yearly", default: 0
    t.bigint "revenue_daily_cents", default: 0, null: false
    t.string "revenue_daily_currency", default: "USD", null: false
    t.bigint "revenue_monthly_cents", default: 0, null: false
    t.string "revenue_monthly_currency", default: "USD", null: false
    t.bigint "revenue_yearly_cents", default: 0, null: false
    t.string "revenue_yearly_currency", default: "USD", null: false
    t.bigint "alexa_rank_3_months", default: 0
    t.bigint "alexa_rank_1_month", default: 0
    t.bigint "alexa_rank_7_days", default: 0
    t.bigint "alexa_rank_1_day", default: 0
    t.bigint "alexa_rank_delta_3_months", default: 0
    t.bigint "alexa_rank_delta_1_month", default: 0
    t.bigint "alexa_rank_delta_7_days", default: 0
    t.bigint "alexa_rank_delta_1_day", default: 0
    t.bigint "alexa_reach_3_months", default: 0
    t.bigint "alexa_reach_1_month", default: 0
    t.bigint "alexa_reach_7_days", default: 0
    t.bigint "alexa_reach_1_day", default: 0
    t.bigint "alexa_reach_delta_3_months", default: 0
    t.bigint "alexa_reach_delta_1_month", default: 0
    t.bigint "alexa_reach_delta_7_days", default: 0
    t.bigint "alexa_reach_delta_1_day", default: 0
    t.float "alexa_pageviews_3_months"
    t.float "alexa_pageviews_1_month"
    t.float "alexa_pageviews_7_days"
    t.float "alexa_pageviews_1_day"
    t.float "alexa_pageviews_delta_3_months"
    t.float "alexa_pageviews_delta_1_month"
    t.float "alexa_pageviews_delta_7_days"
    t.float "alexa_pageviews_delta_1_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_traffic_estimates_on_property_id"
  end

  create_table "publisher_invoices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "currency", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.date "sent_at"
    t.date "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_publisher_invoices_on_end_date"
    t.index ["paid_at"], name: "index_publisher_invoices_on_paid_at"
    t.index ["start_date"], name: "index_publisher_invoices_on_start_date"
    t.index ["user_id"], name: "index_publisher_invoices_on_user_id"
  end

  create_table "scheduled_organization_reports", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.text "subject", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "frequency", null: false
    t.string "dataset", null: false
    t.bigint "campaign_ids", default: [], null: false, array: true
    t.string "recipients", default: [], null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_scheduled_organization_reports_on_organization_id"
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
    t.uuid "legacy_id"
    t.bigint "organization_id"
    t.string "stripe_customer_id"
    t.bigint "referring_user_id"
    t.string "referral_code"
    t.integer "referral_click_count", default: 0
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_campaign"
    t.string "utm_term"
    t.string "utm_content"
    t.string "status", default: "active"
    t.boolean "record_inbound_emails", default: false
    t.index "lower((email)::text)", name: "index_users_on_email", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["referring_user_id"], name: "index_users_on_referring_user_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["object"], name: "index_versions_on_object", using: :gin
    t.index ["object_changes"], name: "index_versions_on_object_changes", using: :gin
  end

  add_foreign_key "pixels", "organizations"
  add_foreign_key "pixels", "users"

  create_view "regions", sql_definition: <<-SQL
      SELECT 1 AS id,
      'Africa'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      75 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      38 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      53 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      38 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      68 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      23 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      38 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      45 AS web_development_and_backend_ecpm_cents,
      '{AO,BF,BI,BJ,BW,CD,CF,CG,CI,CM,CV,DJ,DZ,EG,EH,ER,ET,GA,GH,GM,GN,GQ,GW,IO,KE,KM,LR,LS,LY,MA,MG,ML,MR,MU,MW,MZ,NA,NE,NG,RE,RW,SC,SD,SH,SL,SN,SO,SS,ST,SZ,TD,TG,TN,TZ,UG,YT,ZA,ZM,ZW}'::text[] AS country_codes
  UNION ALL
   SELECT 2 AS id,
      'Americas - Central and Southern'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      150 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      75 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      105 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      75 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      135 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      45 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      75 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      90 AS web_development_and_backend_ecpm_cents,
      '{AR,BO,BR,BZ,CL,CO,CR,EC,FK,GF,GS,GT,GY,HN,MX,NI,PA,PE,PY,SR,SV,UY,VE}'::text[] AS country_codes
  UNION ALL
   SELECT 3 AS id,
      'Americas - Northern'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      750 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      375 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      525 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      375 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      675 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      225 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      375 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      450 AS web_development_and_backend_ecpm_cents,
      '{US,CA}'::text[] AS country_codes
  UNION ALL
   SELECT 4 AS id,
      'Asia - Central and South-Eastern'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      225 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      113 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      158 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      113 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      203 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      68 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      113 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      135 AS web_development_and_backend_ecpm_cents,
      '{BN,ID,KG,KH,KZ,LA,MM,MY,PH,SG,TH,TJ,TL,TM,UZ,VN}'::text[] AS country_codes
  UNION ALL
   SELECT 5 AS id,
      'Asia - Eastern'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      225 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      113 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      158 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      113 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      203 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      68 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      113 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      135 AS web_development_and_backend_ecpm_cents,
      '{CN,HK,JP,KP,KR,MN,MO,TW}'::text[] AS country_codes
  UNION ALL
   SELECT 6 AS id,
      'Asia - Southern and Western'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      225 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      113 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      158 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      113 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      203 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      68 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      113 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      135 AS web_development_and_backend_ecpm_cents,
      '{AE,AF,AM,AZ,BD,BH,BT,CY,GE,IL,IN,IQ,IR,JO,KW,LB,LK,MV,NP,OM,PK,PS,QA,SA,SY,TR,YE}'::text[] AS country_codes
  UNION ALL
   SELECT 7 AS id,
      'Australia and New Zealand'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      750 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      375 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      525 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      375 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      675 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      225 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      375 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      450 AS web_development_and_backend_ecpm_cents,
      '{AU,CC,CX,NF,NZ}'::text[] AS country_codes
  UNION ALL
   SELECT 8 AS id,
      'Europe'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      675 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      338 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      473 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      338 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      608 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      203 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      338 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      405 AS web_development_and_backend_ecpm_cents,
      '{AD,AL,AT,AX,BA,BE,CH,DE,DK,EE,ES,FI,FO,FR,GB,GG,GI,GR,HR,IE,IM,IS,IT,JE,LI,LT,LU,LV,MC,ME,MK,MT,NL,NO,PT,RS,SE,SI,SJ,SM,VA}'::text[] AS country_codes
  UNION ALL
   SELECT 9 AS id,
      'Europe - Eastern'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      450 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      225 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      315 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      225 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      405 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      135 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      225 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      270 AS web_development_and_backend_ecpm_cents,
      '{BG,BY,CZ,HU,MD,PL,RO,RU,SK,UA}'::text[] AS country_codes
  UNION ALL
   SELECT 10 AS id,
      'Other'::text AS name,
      'USD'::text AS blockchain_ecpm_currency,
      75 AS blockchain_ecpm_cents,
      'USD'::text AS css_and_design_ecpm_currency,
      38 AS css_and_design_ecpm_cents,
      'USD'::text AS dev_ops_ecpm_currency,
      53 AS dev_ops_ecpm_cents,
      'USD'::text AS game_development_ecpm_currency,
      38 AS game_development_ecpm_cents,
      'USD'::text AS javascript_and_frontend_ecpm_currency,
      68 AS javascript_and_frontend_ecpm_cents,
      'USD'::text AS miscellaneous_ecpm_currency,
      23 AS miscellaneous_ecpm_cents,
      'USD'::text AS mobile_development_ecpm_currency,
      38 AS mobile_development_ecpm_cents,
      'USD'::text AS web_development_and_backend_ecpm_currency,
      45 AS web_development_and_backend_ecpm_cents,
      '{AG,AI,AS,AW,BB,BL,BM,BQ,BS,CK,CU,CW,DM,DO,FJ,FM,GD,GL,GP,GU,HT,JM,KI,KN,KY,LC,MF,MH,MP,MQ,MS,NC,NR,NU,PF,PG,PM,PN,PR,PW,SB,SX,TC,TK,TO,TT,TV,UM,VC,VG,VI,VU,WF,WS}'::text[] AS country_codes;
  SQL
  create_view "audiences", sql_definition: <<-SQL
      SELECT 1 AS id,
      'Blockchain'::text AS name,
      'blockchain_ecpm_cents'::text AS ecpm_column_name,
      '{Blockchain,Cryptography,Solidity}'::text[] AS keywords
  UNION ALL
   SELECT 2 AS id,
      'CSS & Design'::text AS name,
      'css_and_design_ecpm_cents'::text AS ecpm_column_name,
      '{"CSS & Design"}'::text[] AS keywords
  UNION ALL
   SELECT 3 AS id,
      'DevOps'::text AS name,
      'dev_ops_ecpm_cents'::text AS ecpm_column_name,
      '{DevOps,Security,Serverless}'::text[] AS keywords
  UNION ALL
   SELECT 4 AS id,
      'Game Development'::text AS name,
      'game_development_ecpm_cents'::text AS ecpm_column_name,
      '{"Game Development","Virtual Reality"}'::text[] AS keywords
  UNION ALL
   SELECT 5 AS id,
      'JavaScript & Frontend'::text AS name,
      'javascript_and_frontend_ecpm_cents'::text AS ecpm_column_name,
      '{Angular,Dart,Frontend,JavaScript,React,VueJS}'::text[] AS keywords
  UNION ALL
   SELECT 6 AS id,
      'Miscellaneous'::text AS name,
      'miscellaneous_ecpm_cents'::text AS ecpm_column_name,
      '{C,D,"Developer Resources",Erlang,F#,Haskell,IoT,Julia,"Machine Learning",Other,Q,R,Rust,Scala}'::text[] AS keywords
  UNION ALL
   SELECT 7 AS id,
      'Mobile Development'::text AS name,
      'mobile_development_ecpm_cents'::text AS ecpm_column_name,
      '{Android,"Hybrid & Mobile Web",Kotlin,Objective-C,Swift,iOS}'::text[] AS keywords
  UNION ALL
   SELECT 8 AS id,
      'Web Development & Backend'::text AS name,
      'web_development_and_backend_ecpm_cents'::text AS ecpm_column_name,
      '{.NET,Backend,Database,Go,Groovy,Java,PHP,PL/SQL,Python,Ruby}'::text[] AS keywords;
  SQL
end
