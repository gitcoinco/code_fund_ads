ENV["RAILS_ENV"] ||= "test"
require "simplecov"
require "factory_bot_rails"
SimpleCov.start
require_relative "../config/environment"
require_relative "./mmdb_test_helper"
require "rails/test_help"
require "webmock/minitest"
require "mocha/minitest"
require "sidekiq/testing"

WebMock.allow_net_connect!

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

unless Webpacker.compiler.fresh?
  puts "== Webpack compiling =="
  Webpacker.compiler.compile
  puts "== Webpack compiled =="
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers

  workers = ENV["TEST_CONCURRENCY"].present? ? ENV["TEST_CONCURRENCY"].to_i : (Concurrent.processor_count / 3.to_f).round
  if workers > 1
    puts "Running tests with #{workers} worker processes..."
    parallelize workers: workers
  end

  def teardown
    Sidekiq::Worker.clear_all
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_user(user)
    sign_in user
    post user_session_url
  end

  def attach_small_image!(user)
    name = "seed-200x200.png"
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/seed-200x200.png")),
      filename: "seed-200x200.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 200,
        height: 200,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::SMALL,
      }
    )
    user.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::SMALL).order(created_at: :desc).first
  end

  def attach_large_image!(user)
    name = "seed-260x200.png"
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/seed-260x200.png")),
      filename: "seed-260x200.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 260,
        height: 200,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::LARGE,
      }
    )
    user.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::LARGE).order(created_at: :desc).first
  end

  def attach_wide_image!(user)
    name = "seed-512x320.jpg"
    user.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/seed-512x320.jpg")),
      filename: "seed-512x320.jpg",
      content_type: "image/jpeg",
      metadata: {
        identified: true,
        width: 512,
        height: 320,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::WIDE,
      }
    )
    user.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::WIDE).order(created_at: :desc).first
  end

  def attach_sponsor_image!(user)
    name = "sponsor-heroku.svg"
    user.images.attach(
      io: File.open(Rails.root.join("test/assets/images/sponsor-heroku.svg")),
      filename: "sponsor-heroku.svg",
      content_type: "image/svg+xml",
      metadata: {
        identified: true,
        width: 400,
        height: 40,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::SPONSOR,
      },
    )
    user.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::SPONSOR).order(created_at: :desc).first
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
    data = Mmdb.lookup(ip) || {}
    while data.to_hash.dig("country", "iso_code") != country_code
      data = Mmdb.lookup(ip = Faker::Internet.public_ip_v4_address) || {}
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
