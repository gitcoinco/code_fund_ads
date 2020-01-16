# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address_1              :string
#  address_2              :string
#  api_access             :boolean          default(FALSE), not null
#  api_key                :string
#  bio                    :text
#  city                   :string
#  company_name           :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country                :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           not null
#  encrypted_password     :string           not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string           not null
#  github_username        :string
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  linkedin_username      :string
#  locked_at              :datetime
#  paypal_email           :string
#  postal_code            :string
#  referral_click_count   :integer          default(0)
#  referral_code          :string
#  region                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  roles                  :string           default([]), is an Array
#  sign_in_count          :integer          default(0), not null
#  skills                 :text             default([]), is an Array
#  status                 :string           default("active")
#  twitter_username       :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  us_resident            :boolean          default(FALSE)
#  utm_campaign           :string
#  utm_content            :string
#  utm_medium             :string
#  utm_source             :string
#  utm_term               :string
#  website_url            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#  legacy_id              :uuid
#  organization_id        :bigint
#  referring_user_id      :bigint
#  stripe_customer_id     :string
#
# Indexes
#
#  index_users_on_confirmation_token                 (confirmation_token) UNIQUE
#  index_users_on_email                              (lower((email)::text)) UNIQUE
#  index_users_on_invitation_token                   (invitation_token) UNIQUE
#  index_users_on_invitations_count                  (invitations_count)
#  index_users_on_invited_by_id                      (invited_by_id)
#  index_users_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_users_on_organization_id                    (organization_id)
#  index_users_on_referral_code                      (referral_code) UNIQUE
#  index_users_on_referring_user_id                  (referring_user_id)
#  index_users_on_reset_password_token               (reset_password_token) UNIQUE
#  index_users_on_unlock_token                       (unlock_token) UNIQUE
#

require "factory_bot_rails"
require "faker"

FactoryBot.define do
  factory :user do
    first_name { Faker::TvShows::SiliconValley.character.split.first }
    last_name { Faker::TvShows::SiliconValley.character.split.last }
    confirmation_sent_at { Time.current }
    confirmed_at { Time.current }
    password { "secret" }

    trait :with_address do
      address_1 { Faker::Address.street_address }
      city { Faker::Address.city }
      region { Faker::Address.state }
      postal_code { Faker::Address.zip_code }
      country { "United States" }
      us_resident { true }
    end

    trait :with_social_media do
      github_username { Faker::Internet.username(specifier: 8) }
      linkedin_username { Faker::Internet.username(specifier: 8) }
      twitter_username { Faker::Twitter.screen_name }
    end
  end

  factory :admin, parent: :user do
    organization_id { 1 }
    email { "admin-#{SecureRandom.hex[0, 6]}@codefund.io" }
    roles { [ENUMS::USER_ROLES::ADMINISTRATOR] }
  end

  factory :advertiser, parent: :user do
    organization_id { Organization.where("id > 1").pluck(:id).sample }
    email { "advertiser-#{SecureRandom.hex[0, 6]}@codefund.io" }
    roles { [ENUMS::USER_ROLES::ADVERTISER] }

    after :build do |advertiser|
      advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/seed-200x200.png")),
                               filename: "seed-200x200.png",
                               content_type: "image/png",
                               metadata: {
                                 identified: true,
                                 width: 200,
                                 height: 200,
                                 analyzed: true,
                                 name: "seed-200x200.png",
                                 format: ENUMS::IMAGE_FORMATS::SMALL,
                               }

      advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/seed-260x200.png")),
                               filename: "seed-260x200.png",
                               content_type: "image/png",
                               metadata: {
                                 identified: true,
                                 width: 260,
                                 height: 200,
                                 analyzed: true,
                                 name: "seed-260x200.png",
                                 format: ENUMS::IMAGE_FORMATS::LARGE,
                               }

      advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/seed-512x320.jpg")),
                               filename: "seed-512x320.jpg",
                               content_type: "image/jpeg",
                               metadata: {
                                 identified: true,
                                 width: 512,
                                 height: 320,
                                 analyzed: true,
                                 name: "seed-512x320.jpg",
                                 format: ENUMS::IMAGE_FORMATS::WIDE,
                               }
    end
  end

  factory :publisher, parent: :user do
    email { "publisher-#{SecureRandom.hex[0, 6]}@codefund.io" }
    roles { [ENUMS::USER_ROLES::PUBLISHER] }
  end
end
