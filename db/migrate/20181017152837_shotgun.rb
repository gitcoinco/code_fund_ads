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

    create_table :impressions, id: false, options: "PARTITION BY RANGE (advertiser_id, displayed_at_date)" do |t|
      t.uuid :id, null: false, default: "gen_random_uuid()"
      t.bigint :advertiser_id, null: false
      t.bigint :publisher_id, null: false
      t.bigint :campaign_id, null: false
      t.bigint :creative_id, null: false
      t.bigint :property_id, null: false
      t.string :campaign_name, null: false
      t.string :property_name, null: false
      t.string :ip_address, null: false
      t.text :user_agent, null: false
      t.string :country_code
      t.string :postal_code
      t.decimal :latitude
      t.decimal :longitude
      t.datetime :displayed_at, default: "now()", null: false
      t.date :displayed_at_date, default: "now()::date", null: false
      t.datetime :clicked_at
      t.date :clicked_at_date
      t.boolean :fallback_campaign, default: false, null: false

      t.index [:id, :advertiser_id, :displayed_at_date], unique: true
      t.index :advertiser_id
      t.index :campaign_id
      t.index :creative_id
      t.index :property_id
      t.index :campaign_name
      t.index :property_name
      t.index :country_code
      t.index :displayed_at_date
      t.index "date_trunc('hour', displayed_at)", name: "index_impressions_on_displayed_at_hour"
      t.index :clicked_at_date
      t.index "date_trunc('hour', clicked_at)", name: "index_impressions_on_clicked_at_hour"
    end

    reversible do |dir|
      dir.up do
        execute "CREATE TABLE impressions_default PARTITION OF impressions DEFAULT;"
      end
      dir.down do
        drop_table :impressions_default
      end
    end

    create_table :properties do |t|
      t.bigint :user_id, null: false
      t.string :property_type, null: false
      t.string :status, null: false
      t.string :name, null: false
      t.text :description
      t.text :url, null: false
      t.string :ad_template
      t.string :ad_theme
      t.string :language, null: false
      t.string :keywords, default: [], null: false, array: true
      t.bigint :prohibited_advertiser_ids, default: [], null: false, array: true
      t.boolean :prohibit_fallback_campaigns, default: false, null: false
      t.timestamps

      t.index :user_id
      t.index :property_type
      t.index :status
      t.index "lower(name)", name: "index_properties_on_name"
      t.index :keywords, using: :gin
      t.index :prohibited_advertiser_ids, using: :gin
    end

    create_table :publisher_invoices do |t|
      t.bigint :user_id, null: false
      t.monetize :amount, null: false
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
      t.text :skills, default: [], array: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country
      t.boolean :us_resident, default: false
      t.boolean :api_access, default: false, null: false
      t.string :api_key
      t.text :bio
      t.string :website_url
      t.string :github_username
      t.string :twitter_username
      t.string :linkedin_username
      t.string :paypal_email

      ## Database authenticatable
      t.string :email, null: false
      t.string :encrypted_password, null: false

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip

      ## Confirmable
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Invitable
      t.string :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer :invitations_count, default: 0
      t.index :invitations_count
      t.index :invitation_token, unique: true # for invitable
      t.index :invited_by_id

      t.timestamps

      t.index "lower(email)", unique: true, name: "index_users_on_email"
      t.index :reset_password_token, unique: true
      t.index :confirmation_token, unique: true
      t.index :unlock_token, unique: true
    end
  end
end
