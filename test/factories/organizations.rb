# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("USD"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "factory_bot_rails"
require "faker"

FactoryBot.define do
  factory :organization do
    name { "#{Faker::TvShows::SiliconValley.company} #{SecureRandom.hex.upcase[0, 6]}" }
    balance_cents { rand(0..500000) }
    balance_currency { "USD" }
    created_at { rand(5..10).days.ago }
    updated_at { rand(1..3).days.ago }

    trait :with_small_balance do
      balance_cents { rand(0..50000) }
    end

    trait :with_medium_balance do
      balance_cents { rand(50000..250000) }
    end

    trait :with_large_balance do
      balance_cents { rand(250000..500000) }
    end

    factory :organization_with_campaigns do
      transient do
        campaigns_count { 3 }
      end

      after(:create) do |organization, evaluator|
        create_list(:campaign, evaluator.campaigns_count, organization: organization)
      end
    end
  end
end
