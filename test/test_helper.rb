ENV["RAILS_ENV"] ||= "test"
require "simplecov"
SimpleCov.start
require_relative "../config/environment"
require_relative "./mmdb_test_helper"
require "rails/test_help"
require "webmock/minitest"

WebMock.allow_net_connect!

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
# Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def attach_small_image!(user)
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/seed-200x200.png")),
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
    ).first
  end

  def attach_large_image!(user)
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/seed-260x200.png")),
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
    ).first
  end

  def attach_wide_image!(user)
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/seed-512x320.jpg")),
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
    ).first
  end

  def attach_sponsor_image!(user)
    user.images.attach(
      io: File.open(Rails.root.join("test/assets/images/sponsor-heroku.svg")),
      filename: "sponsor-heroku.svg",
      content_type: "image/svg+xml",
      metadata: {
        identified: true,
        width: 400,
        height: 40,
        analyzed: true,
        name: "sponsor-heroku.svg",
        format: ENUMS::IMAGE_FORMATS::SPONSOR,
      },
    ).first
  end

  # Factory method to find a fixture and update its attributes
  def amend(options = {})
    fixture_class_name, fixture_name = options.shift
    send(fixture_class_name, fixture_name).tap { |instance| instance.update! options }
  end

  # Factory method to copy a fixture and save it with amended attributes
  def copy(options = {})
    fixture_class_name, fixture_name = options.shift
    instance = send(fixture_class_name, fixture_name)
    attributes = instance.attributes.dup.with_indifferent_access.slice!(:id)
    instance.class.create! attributes.merge(options)
  end

  def ip_address(country_code)
    attempts = 0
    ip = Faker::Internet.public_ip_v4_address
    data = MMDB.lookup(ip) || {}
    while data.to_hash.dig("country", "iso_code") != country_code
      data = MMDB.lookup(ip = Faker::Internet.public_ip_v4_address) || {}
      attempts += 1
      puts "#{attempts} attempts to find IP address for: #{country_code}" if attempts % 50 == 0
    end
    ip
  end

  def premium_impression(params = {})
    impression = Impression.first_or_create!(
      advertiser: users(:advertiser),
      publisher: users(:publisher),
      campaign: campaigns(:premium),
      creative: creatives(:premium),
      property: properties(:website),
      ip_address: "127.0.0.1",
      user_agent: "test",
      country_code: "US",
      displayed_at: Time.current,
      displayed_at_date: Date.current,
    )
    impression.update! params if params.present?
    impression
  end

  def fallback_impression(params = {})
    impression = Impression.first_or_create!(
      advertiser: users(:advertiser),
      publisher: users(:publisher),
      campaign: campaigns(:fallback),
      creative: creatives(:fallback),
      property: properties(:website),
      ip_address: "127.0.0.1",
      user_agent: "test",
      country_code: "US",
      displayed_at: Time.current,
      displayed_at_date: Date.current,
    )
    impression.update params if params.present?
    impression
  end

  def active_campaign(country_codes: [])
    campaign = campaigns(:premium)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ACTIVE,
      start_date: 1.month.ago.beginning_of_month,
      end_date: 1.month.from_now.end_of_month,
      country_codes: country_codes,
      keywords: ENUMS::KEYWORDS.keys.sample(10)
    )
    campaign.creative.add_image! attach_large_image!(campaign.user)
    campaign.organization.update balance: Monetize.parse("$10,000 USD")
    campaign
  end

  def inactive_campaign
    campaign = campaigns(:premium)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED,
      start_date: 6.months.ago.beginning_of_month,
      end_date: 4.months.ago.end_of_month,
      keywords: ENUMS::KEYWORDS.keys.sample(10)
    )
    campaign
  end

  def fallback_campaign
    campaign = campaigns(:premium)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ACTIVE,
      start_date: 1.month.ago.beginning_of_month,
      end_date: 1.month.from_now.end_of_month,
      keywords: [],
      fallback: true
    )
    campaign.creative.add_image! attach_large_image!(campaign.user)
    campaign
  end

  def matched_property(campaign, fixture: :website)
    property = properties(fixture)
    property.update! keywords: campaign.keywords.sample(5)
    property
  end
end
