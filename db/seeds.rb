require "factory_bot_rails"
require "benchmark"

ActionMailer::Base.perform_deliveries = false

unless Rails.env.development? || ENV["ALLOW_SEED"] == true
  puts "Seeds are for development only."
  exit 1
end

Benchmark.bm(20) do |x|
  x.report("Organizations:") do
    FactoryBot.create :organization, name: "Code Fund"

    150.times do
      FactoryBot.create :organization
    end
  end

  x.report("Admin:") { FactoryBot.create :admin }

  x.report("Advertisers:") do
    175.times do
      FactoryBot.create :advertiser
    end
  end

  x.report("Publishers:") do
    1000.times do
      FactoryBot.create :publisher
    end
  end

  x.report("Creatives:") do
    User.advertisers.each do |advertiser|
      5.times do
        FactoryBot.create :creative, user_id: advertiser.id
      end
    end
  end

  x.report("Campaigns:") do
    User.advertisers.each do |advertiser|
      FactoryBot.create :campaign, user_id: advertiser.id
    end
  end

  x.report("Properties:") {
    User.publishers.each do |publisher|
      rand(1..2).times do
        FactoryBot.create :property, user_id: publisher.id
      end
    end
  }

  # x.report("Impressions:") {
  # }
end
