# == Schema Information
#
# Table name: creatives
#
#  id              :bigint           not null, primary key
#  body            :text
#  creative_type   :string           default("standard"), not null
#  cta             :string
#  headline        :string
#  name            :string           not null
#  status          :string           default("pending")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_creatives_on_creative_type    (creative_type)
#  index_creatives_on_organization_id  (organization_id)
#  index_creatives_on_user_id          (user_id)
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
