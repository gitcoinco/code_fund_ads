# frozen_string_literal: true

class Shotgun < ActiveRecord::Migration[5.2]
  def change
    enable_extension "pg_stat_statements"
    enable_extension "pgcrypto"
    enable_extension "plpgsql"

    create_table :active_storage_attachments do |t|
      t.bigint :blob_id, null: false
      t.bigint :record_id, null: false
      t.string :record_type, null: false
      t.string :name, null: false
      t.datetime :created_at, null: false

      t.index :blob_id
      t.index [:record_type, :record_id, :name, :blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
    end

    create_table :active_storage_blobs do |t|
      t.string :key, null: false
      t.string :filename, null: false
      t.string :content_type
      t.text :metadata
      t.jsonb :indexed_metadata, default: {}
      t.bigint :byte_size, null: false
      t.string :checksum, null: false
      t.datetime :created_at, null: false

      t.index :key, name: "index_active_storage_blobs_on_key", unique: true
      t.index :filename
      t.index :content_type
      t.index :indexed_metadata, using: :gin
    end

    create_table :campaigns do |t|
      t.bigint :user_id
      t.bigint :creative_id
      t.string :status, null: false
      t.boolean :fallback, default: false, null: false
      t.string :name, null: false
      t.text :url, null: false
      t.date :start_date
      t.date :end_date
      t.boolean :us_hours_only, default: false
      t.boolean :weekdays_only, default: false
      t.monetize :total_budget, null: false
      t.monetize :daily_budget, null: false
      t.monetize :ecpm, null: false
      t.string :countries, default: [], array: true
      t.string :keywords, default: [], array: true
      t.string :negative_keywords, default: [], array: true
      t.timestamps

      t.index :user_id
      t.index :creative_id
      t.index :status
      t.index "lower(name)", name: "index_campaigns_on_name"
      t.index :end_date
      t.index :start_date
      t.index :us_hours_only
      t.index :weekdays_only
      t.index :countries, using: :gin
      t.index :keywords, using: :gin
      t.index :negative_keywords, using: :gin
    end

    create_table :creatives, force: :cascade do |t|
      t.bigint :user_id, null: false
      t.string :name, null: false
      t.string :headline, null: false
      t.text :body
      t.timestamps

      t.index :user_id
    end

    create_table :creative_images, force: :cascade do |t|
      t.bigint :creative_id, null: false
      t.bigint :active_storage_attachment_id, null: false
      t.timestamps

      t.index :creative_id
      t.index :active_storage_attachment_id
    end

    create_range_partition :impressions, id: :uuid, default: -> { "gen_random_uuid()" }, partition_key: "displayed_at_date" do |t|
      t.bigint :campaign_id
      t.bigint :property_id
      t.string :ip
      t.text :user_agent
      t.string :country
      t.string :postal_code
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :payable, default: false, null: false
      t.string :reason
      t.datetime :displayed_at
      t.date :displayed_at_date
      t.datetime :clicked_at
      t.boolean :fallback_campaign, default: false, null: false
      t.timestamps
    end

    start_date = Date.parse("2018-11-01")
    current_date = start_date
    while current_date < Date.parse("2031-01-01")
      next_date = current_date.advance(months: 1)
      partitioned_table_name = "impressions-#{current_date.to_s "yyyy-mm"}"
      create_range_partition_of :impressions, name: partitioned_table_name, partition_key: "displayed_at_date", start_range: current_date, end_range: next_date
      # NOTE: displayed_at_date is indexed by default since it's the partition key
      add_index partitioned_table_name, "date_trunc('hour', displayed_at)", name: "index_#{partitioned_table_name}_on_displayed_at_hour"
      add_index partitioned_table_name, :campaign_id
      add_index partitioned_table_name, :property_id
      add_index partitioned_table_name, :payable
      current_date = next_date
    end

    create_table :properties do |t|
      t.bigint :user_id, null: false
      t.string :property_type, null: false
      t.string :status, null: false
      t.string :name, null: false
      t.text :description
      t.text :url, null: false
      t.string :ad_template, null: false
      t.string :ad_theme, null: false
      t.string :language, null: false
      t.string :keywords, default: [], null: false, array: true
      t.bigint :prohibited_advertisers, default: [], array: true
      t.boolean :prohibit_fallback_campaigns, default: false, null: false
      t.timestamps

      t.index :user_id
      t.index :property_type
      t.index :status
      t.index "lower(name)", name: "index_properties_on_name"
      t.index :keywords, using: :gin
      t.index :prohibited_advertisers, using: :gin
    end

    create_table :publisher_invoices do |t|
      t.bigint :user_id, null: false
      t.money :amount, null: false
      t.string :currency, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.date :sent_at
      t.date :paid_at
      t.timestamps

      t.index :user_id
      t.index :start_date
      t.index :end_date
      t.date :paid_at
    end

    create_table :users do |t|
      t.string :roles, default: [], array: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country
      t.boolean :api_access, default: false, null: false
      t.string :api_key
      t.string :paypal_email

      ## Database authenticatable
      t.string :email,              null: false
      t.string :encrypted_password, null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps

      t.index "lower(email)", unique: true, name: "index_users_on_email"
      t.index :reset_password_token, unique: true
      t.index :confirmation_token, unique: true
      t.index :unlock_token, unique: true
    end
  end
end
