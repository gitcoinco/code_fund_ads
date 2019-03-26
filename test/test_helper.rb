ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require_relative "./mmdb_test_helper"
require "rails/test_help"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

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

  # Provides factory like behavior for models/fixtures
  # Copies the passed persisted model instance, assigns passed attrbiutes, and saves to the database
  # Useful when additional test setup is required... i.e. isn't handled by the basic fixtures
  def copy!(source, attributes = {})
    source_attributes = HashWithIndifferentAccess.new(source.attributes.dup)
    source_attributes.delete :id
    source.class.create! source_attributes.merge(attributes)
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
end
