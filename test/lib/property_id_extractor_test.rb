require "test_helper"

class PropertyIdExtractorTest < ActiveSupport::TestCase
  test "/properties/:property_id/funder.js integer" do
    property_id = rand(9999)
    path = "/properties/#{property_id}/funder.js"
    assert PropertyIdExtractor.extract_property_id(path) == property_id.to_s
  end

  test "/properties/:property_id/funder.js integer with querystring" do
    property_id = rand(9999)
    path = "/properties/#{property_id}/funder.js?template=default&theme=unstyled"
    assert PropertyIdExtractor.extract_property_id(path) == property_id.to_s
  end

  test "/properties/:property_id/funder.js legacy_id" do
    legacy_id = SecureRandom.uuid
    path = "/properties/#{legacy_id}/funder.js"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end

  test "/properties/:property_id/funder.json integer" do
    property_id = rand(9999)
    path = "/properties/#{property_id}/funder.json"
    assert PropertyIdExtractor.extract_property_id(path) == property_id.to_s
  end

  test "/properties/:property_id/funder.html integer" do
    property_id = rand(9999)
    path = "/properties/#{property_id}/funder.html"
    assert PropertyIdExtractor.extract_property_id(path) == property_id.to_s
  end

  test "/scripts/:legacy_id/embed.js" do
    legacy_id = SecureRandom.uuid
    path = "/scripts/#{legacy_id}/embed.js"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end

  test "/scripts/:legacy_id/embed.js with querystring" do
    legacy_id = SecureRandom.uuid
    path = "/scripts/#{legacy_id}/embed.js?template=bottom-bar"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end

  test "/t/s/:legacy_id/details" do
    legacy_id = SecureRandom.uuid
    path = "/t/s/#{legacy_id}/details"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end

  test "/t/s/:legacy_id/details with querystring" do
    legacy_id = SecureRandom.uuid
    path = "/t/s/#{legacy_id}/details?template=square&theme=dark"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end

  test "/api/v1/impression/:legacy_id" do
    legacy_id = SecureRandom.uuid
    path = "/api/v1/impression/#{legacy_id}"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end

  test "/api/v1/impression/:legacy_id with querystring?template=text" do
    legacy_id = SecureRandom.uuid
    path = "/api/v1/impression/#{legacy_id}"
    assert PropertyIdExtractor.extract_property_id(path) == legacy_id
  end
end
