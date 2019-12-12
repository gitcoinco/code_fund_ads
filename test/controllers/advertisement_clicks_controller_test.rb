require "test_helper"

class AdvertisementClicksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActiveJob::TestHelper

  setup do
    @impression_id = SecureRandom.uuid
    @campaign = amend(campaigns: :premium, url: "https://example.com")
    @creative = @campaign.creatives.first
    @property = amend(properties: :website, keywords: @campaign.keywords)
    @headers = {"HTTP_REFERER" => @property.url}
    @params = {
      impression_id: @impression_id,
      campaign_id: @campaign.id,
      creative_id: @creative.id,
      property_id: @property.id,
      template: "default",
      theme: "light",
    }
    @expected_query = {
      utm_campaign: @campaign.id.to_s,
      utm_impression: @impression_id,
      utm_medium: "display",
      utm_referrer: @property.url,
      utm_source: "CodeFund",
    }
  end

  test "advertisement click original query UTM parameters" do
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query
  end

  test "advertisement click original query UTM parameters with override" do
    @campaign.update url: "https://example.com?utm_source=override"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(utm_source: "override")
  end

  test "advertisement click {{campaign_id}} URL variable" do
    @campaign.update url: "https://example.com?custom={{campaign_id}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @campaign.id.to_s)
  end

  test "advertisement click {{campaign_name}} URL variable" do
    @campaign.update name: "Ad Click: Campaign Name > Test", url: "https://example.com?custom={{campaign_name}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @campaign.name)
  end

  test "advertisement click {{creative_id}} URL variable" do
    @campaign.update url: "https://example.com?custom={{creative_id}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @creative.id.to_s)
  end

  test "advertisement click {{creative_name}} URL variable" do
    @campaign.update url: "https://example.com?custom={{creative_name}}"
    @creative.update name: "Ad Click: Creative Name > Test"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @creative.name)
  end

  test "advertisement click {{property_id}} URL variable" do
    @campaign.update url: "https://example.com?custom={{property_id}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @property.id.to_s)
  end

  test "advertisement click {{property_name}} URL variable" do
    @campaign.update url: "https://example.com?custom={{property_name}}"
    @property.update name: "Ad Click: Property Name > Test"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @property.name)
  end

  test "advertisement click {{property_url}} URL variable" do
    @campaign.update url: "https://example.com?custom={{property_url}}"
    @property.update url: "https://awesome-publisher.com"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: @property.url)
  end

  test "advertisement click {{template}} URL variable" do
    @campaign.update url: "https://example.com?custom={{template}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: "default")
  end

  test "advertisement click {{theme}} URL variable" do
    @campaign.update url: "https://example.com?custom={{theme}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(custom: "light")
  end

  test "advertisement click all URL variables" do
    @campaign.update url: "https://example.com?campaign_id={{campaign_id}}&campaign_name={{campaign_name}}&creative_id={{creative_id}}&creative_name={{creative_name}}&property_id={{property_id}}&property_name={{property_name}}&property_url={{property_url}}&template={{template}}&theme={{theme}}"
    get advertisement_clicks_url(@impression_id), params: @params, headers: @headers
    assert_response :redirect
    uri = URI.parse(response.headers["Location"])
    parsed_query = Rack::Utils.parse_query(uri.query).symbolize_keys
    assert parsed_query == @expected_query.merge(
      campaign_id: @campaign.id.to_s,
      campaign_name: @campaign.name,
      creative_id: @creative.id.to_s,
      creative_name: @creative.name,
      property_id: @property.id.to_s,
      property_name: @property.name,
      property_url: @property.url,
      template: "default",
      theme: "light",
    )
  end

  test "sponsor advertisement click without active campaign" do
    property = amend(properties: :website, url: "https://github.com/gitcoinco/code_fund_ads")
    ip = ip_address("US")

    Impression.delete_all
    assert Impression.count == 0
    assert property.restrict_to_sponsor_campaigns?
    get sponsor_visit_url(property), headers: {"REMOTE_ADDR": ip, "User-Agent": "Rails/Minitest"}
    assert_response :found
    assert headers["Location"] == "https://codefund.io"
    assert Impression.count == 0
  end

  test "sponsor advertisement click" do
    campaign = active_campaign(country_codes: ["US"])
    campaign.creatives.each do |creative|
      creative.standard_images.destroy_all
      creative.update! creative_type: ENUMS::CREATIVE_TYPES::SPONSOR
      CreativeImage.create! creative: creative, image: attach_sponsor_image!(campaign.user)
    end
    property = matched_property(campaign)
    property.update! url: "https://github.com/gitcoinco/code_fund_ads"
    campaign.update! assigned_property_ids: [property.id]
    ip = ip_address("US")

    Impression.delete_all
    assert Impression.count == 0
    assert campaign.sponsor?
    assert property.restrict_to_sponsor_campaigns?
    assert campaign.creatives.size == 1
    assert campaign.sponsor_creatives.size == 1

    perform_enqueued_jobs do
      get sponsor_visit_url(property), headers: {"REMOTE_ADDR": ip, "User-Agent": "Rails/Minitest"}
    end
    campaign.reload

    assert_response :found
    assert headers["Location"] == "https://example.com?utm_campaign=154997895&utm_impression=&utm_medium=display&utm_referrer=&utm_source=CodeFund"
    assert Impression.count == 1
    impression = Impression.first
    assert impression.campaign_id == campaign.id
    assert impression.property_id == property.id
    assert impression.clicked?
  end
end
