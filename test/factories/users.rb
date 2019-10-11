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
