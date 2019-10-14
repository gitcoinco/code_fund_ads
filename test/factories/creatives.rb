# == Schema Information
#
# Table name: creatives
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  name            :string           not null
#  headline        :string
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint
#  cta             :string
#  status          :string           default("pending")
#  creative_type   :string           default("standard"), not null
#

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
