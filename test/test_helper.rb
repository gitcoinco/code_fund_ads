# Only run in CI
if ENV["CI"] == "true"
  require "simplecov"
  require "codecov"
  SimpleCov.start "rails"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require_relative "./mmdb_test_helper"
require "rails/test_help"
require "action_mailbox/test_helper"
require "webmock/minitest"
require "mocha/minitest"
require "sidekiq/testing"
require "view_component/test_helpers"

WebMock.allow_net_connect!

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

unless Webpacker.compiler.fresh?
  puts "== Webpack compiling =="
  Webpacker.compiler.compile
  puts "== Webpack compiled =="
end

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  include ActionMailbox::TestHelper

  workers = ENV["TEST_CONCURRENCY"].present? ? ENV["TEST_CONCURRENCY"].to_i : (Concurrent.processor_count / 3.to_f).round
  if workers > 1
    puts "Running tests with #{workers} worker processes..."
    parallelize workers: workers
  end

  def teardown
    Sidekiq::Worker.clear_all
    Rails.local_ephemeral_cache.clear
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_user(user)
    sign_in user
    post user_session_url
  end

  # FIXME: This is a hack
  def stub_warden(request)
    request.env["warden"] = Warden::Proxy.new("test", Warden::Manager.new(Rails.application))
  end

  def create_comment(commentable: nil, user: nil, body: "Test comment.")
    return unless commentable && user
    comment = Comment.build_from(commentable, user.id, body)
    comment.save
    comment
  end

  def attach_all_images!(creative:, organization:)
    creative.add_image! attach_icon_image!(organization)
    creative.add_image! attach_small_image!(organization)
    creative.add_image! attach_large_image!(organization)
    creative.add_image! attach_wide_image!(organization)
  end

  def attach_icon_image!(record)
    name = "seed-20x20.png"
    record.images.attach(
      io: File.open(Rails.root.join("test/assets/images/seeds/seed-20x20.png")),
      filename: "seed-20x20.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 20,
        height: 20,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::ICON
      }
    )
    record.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::ICON).order(created_at: :desc).first
  end

  def attach_small_image!(record)
    name = "seed-200x200.png"
    record.images.attach(
      io: File.open(Rails.root.join("test/assets/images/seeds/seed-200x200.png")),
      filename: "seed-200x200.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 200,
        height: 200,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::SMALL
      }
    )
    record.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::SMALL).order(created_at: :desc).first
  end

  def attach_large_image!(record)
    name = "seed-260x200.png"
    record.images.attach(
      io: File.open(Rails.root.join("test/assets/images/seeds/seed-260x200.png")),
      filename: "seed-260x200.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 260,
        height: 200,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::LARGE
      }
    )
    record.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::LARGE).order(created_at: :desc).first
  end

  def attach_wide_image!(record)
    name = "seed-512x320.jpg"
    record.images.attach(
      io: File.open(Rails.root.join("test/assets/images/seeds/seed-512x320.jpg")),
      filename: "seed-512x320.jpg",
      content_type: "image/jpeg",
      metadata: {
        identified: true,
        width: 512,
        height: 320,
        analyzed: true,
        name: name,
        format: ENUMS::IMAGE_FORMATS::WIDE
      }
    )
    record.images.search_metadata_name(name).metadata_format(ENUMS::IMAGE_FORMATS::WIDE).order(created_at: :desc).first
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
    {
      "CN" => "222.77.185.153",
      "US" => "52.54.11.217"
    }[country_code]
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
      displayed_at_date: Date.current
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
      displayed_at_date: Date.current
    )
    impression.update! params if params.present?
    impression
  end

  def active_campaign(attrs = {})
    campaign = campaigns(:premium_bundled)
    campaign.update! attrs if attrs.present?
    campaign.creative.add_image! attach_large_image!(campaign.organization)
    campaign.organization.update! balance: Monetize.parse("$10,000 USD")
    campaign
  end

  def inactive_campaign
    campaign = campaigns(:premium_bundled)
    assert campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED,
      start_date: 6.months.ago.beginning_of_month,
      end_date: 4.months.ago.end_of_month
    )
    campaign
  end

  def fallback_campaign
    campaign = campaigns(:fallback)
    campaign.creative.add_image! attach_large_image!(campaign.organization)
    campaign
  end

  def matched_property(campaign, fixture: :website)
    property = properties(fixture)
    keywords = campaign.keywords.sample(5)
    if campaign.audience_ids.present?
      assert property.update(audience_id: campaign.audience_ids.sample)
    elsif campaign.premium?
      assert campaign.keywords.present?
      assert keywords.present?
    end
    assert property.update(audience_id: nil, keywords: keywords)
    property
  end
end
