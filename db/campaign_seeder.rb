class CampaignSeeder
  def self.create_campaign(advertiser, date)
    start_date = date.to_date.advance(months: -rand(1..2))
    end_date = start_date.advance(months: rand(1..2))
    total_budget = ([*500..5000].sample / 100) * 100
    daily_budget = total_budget / (end_date - start_date).to_i
    countries = ENUMS::DEVELOPED_MARKET_COUNTRIES.keys
    countries += ENUMS::EMERGING_MARKET_COUNTRIES.keys if rand(3).zero?
    countries += ENUMS::COUNTRIES.keys.sample(5) if rand(5).zero?
    keywords = ENUMS::KEYWORDS.values.sample(25)
    negative_keywords = ENUMS::KEYWORDS.values.sample(2) - keywords

    Campaign.create(
      user: advertiser,
      creative: advertiser.creatives.sample,
      status: ENUMS::CAMPAIGN_STATUSES.values.sample,
      name: "#{Faker::Company.name} #{SecureRandom.hex.to_s[0, 6]}",
      url: Faker::SiliconValley.url,
      start_date: start_date,
      end_date: end_date,
      core_hours_only: rand(5).zero?,
      weekdays_only: rand(5).zero?,
      total_budget: total_budget,
      daily_budget: daily_budget,
      ecpm: rand(1..3),
      countries: countries,
      keywords: keywords,
      negative_keywords: negative_keywords
    )
  end
end
