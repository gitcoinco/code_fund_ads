require "factory_bot_rails"
require "faker"

FactoryBot.define do
  factory :creative do
    association :user, factory: :advertiser

    name { Faker::TvShows::SiliconValley.company }
    headline { Faker::TvShows::SiliconValley.invention }
    body { Faker::TvShows::SiliconValley.motto }
    cta { "Click Here" }

    after :create do |creative|
      creative.user.images.each do |image|
        CreativeImage.create creative: creative, image: image
      end
    end
  end
end
