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

ActiveRecord::Schema.define(version: 2019_02_13_224041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
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

  create_table "applicants", force: :cascade do |t|
    t.string "status", default: "pending"
    t.string "role", null: false
    t.string "email", null: false
    t.string "canonical_email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "url", null: false
    t.string "monthly_visitors"
    t.string "company_name"
    t.string "monthly_budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invited_user_id"
    t.bigint "referring_user_id"
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
    t.index "lower((name)::text)", name: "index_campaigns_on_name"
    t.index ["core_hours_only"], name: "index_campaigns_on_core_hours_only"
    t.index ["country_codes"], name: "index_campaigns_on_country_codes", using: :gin
    t.index ["creative_id"], name: "index_campaigns_on_creative_id"
    t.index ["end_date"], name: "index_campaigns_on_end_date"
    t.index ["job_posting"], name: "index_campaigns_on_job_posting"
    t.index ["keywords"], name: "index_campaigns_on_keywords", using: :gin
    t.index ["negative_keywords"], name: "index_campaigns_on_negative_keywords", using: :gin
    t.index ["organization_id"], name: "index_campaigns_on_organization_id"
    t.index ["province_codes"], name: "index_campaigns_on_province_codes", using: :gin
    t.index ["start_date"], name: "index_campaigns_on_start_date"
    t.index ["status"], name: "index_campaigns_on_status"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
    t.index ["weekdays_only"], name: "index_campaigns_on_weekdays_only"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "commentable_id", null: false
    t.string "commentable_type", null: false
    t.string "title"
    t.text "body"
    t.string "subject"
    t.bigint "user_id", null: false
    t.bigint "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "headline", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "legacy_id"
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_creatives_on_organization_id"
    t.index ["user_id"], name: "index_creatives_on_user_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "title", null: false
    t.string "subject", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["gift"], name: "index_organization_transactions_on_gift"
    t.index ["organization_id"], name: "index_organization_transactions_on_organization_id"
    t.index ["reference"], name: "index_organization_transactions_on_reference"
    t.index ["transaction_type"], name: "index_organization_transactions_on_transaction_type"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "prohibited_advertiser_ids", default: [], null: false, array: true
    t.boolean "prohibit_fallback_campaigns", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "legacy_id"
    t.decimal "revenue_percentage", default: "0.5", null: false
    t.index "lower((name)::text)", name: "index_properties_on_name"
    t.index ["keywords"], name: "index_properties_on_keywords", using: :gin
    t.index ["prohibited_advertiser_ids"], name: "index_properties_on_prohibited_advertiser_ids", using: :gin
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
    t.uuid "legacy_id"
    t.bigint "organization_id"
    t.string "stripe_customer_id"
    t.bigint "referring_user_id"
    t.string "referral_code"
    t.integer "referral_click_count", default: 0
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

end
