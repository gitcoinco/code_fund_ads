# frozen_string_literal: true

require "factory_bot_rails"
require "benchmark"
require_relative "./impression_seeder"

ActionMailer::Base.perform_deliveries = false

unless Rails.env.development? || ENV["ALLOW_SEED"] == true
  puts "Seeds are for development only."
  exit 1
end

Benchmark.bm(24) do |benchmark|
  benchmark.report("Organizations:") do
    FactoryBot.create :organization, name: "Code Fund"

    150.times do
      FactoryBot.create :organization
    end
  end

  benchmark.report("Admin:") { FactoryBot.create :admin }

  benchmark.report("Advertisers:") do
    175.times do
      FactoryBot.create :advertiser
    end
  end

  benchmark.report("Publishers:") do
    1000.times do
      FactoryBot.create :publisher
    end
  end

  benchmark.report("Creatives:") do
    User.advertisers.each do |advertiser|
      5.times do
        FactoryBot.create :creative, user_id: advertiser.id
      end
    end
  end

  benchmark.report("Campaigns:") do
    User.advertisers.each do |advertiser|
      FactoryBot.create :campaign, :status_active, user_id: advertiser.id
    end
  end

  benchmark.report("Properties:") do
    User.publishers.each do |publisher|
      rand(1..2).times do
        FactoryBot.create :property, user_id: publisher.id
      end
    end
  end

  benchmark.report("Impressions:") do
    ImpressionSeeder.run
  end
end
