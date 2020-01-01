# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  roles                  :string           default([]), is an Array
#  skills                 :text             default([]), is an Array
#  first_name             :string           not null
#  last_name              :string           not null
#  company_name           :string
#  address_1              :string
#  address_2              :string
#  city                   :string
#  region                 :string
#  postal_code            :string
#  country                :string
#  us_resident            :boolean          default(FALSE)
#  api_access             :boolean          default(FALSE), not null
#  api_key                :string
#  bio                    :text
#  website_url            :string
#  github_username        :string
#  twitter_username       :string
#  linkedin_username      :string
#  paypal_email           :string
#  email                  :string           not null
#  encrypted_password     :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint
#  invitations_count      :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  legacy_id              :uuid
#  organization_id        :bigint
#  stripe_customer_id     :string
#  referring_user_id      :bigint
#  referral_code          :string
#  referral_click_count   :integer          default(0)
#  utm_source             :string
#  utm_medium             :string
#  utm_campaign           :string
#  utm_term               :string
#  utm_content            :string
#  status                 :string           default("active")
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
