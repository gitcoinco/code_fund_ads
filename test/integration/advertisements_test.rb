require "test_helper"
require "faker"

class AdvertisementsTest < ActionDispatch::IntegrationTest
  setup do
    @campaign = campaigns(:premium)
    @campaign.update start_date: Date.parse("2019-01-01"), end_date: Date.parse("2019-04-01"), keywords: ENUMS::KEYWORDS.keys.sample(5)
    @property = properties(:website)
    @property.update keywords: @campaign.keywords.sample(2)
    travel_to @campaign.start_date.to_time.advance(days: 15)
  end

  teardown do
    travel_back
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and undetectable country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "json with targeted keywords and undetectable country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "html with targeted keywords and undetectable country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted country and untargeted keywords" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "json with targeted country and untargeted keywords" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "html with targeted country and untargeted keywords" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and untargeted country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "json with targeted keywords and untargeted country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "html with targeted keywords and untargeted country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and country but $0 organization balance" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "json with targeted keywords and country but $0 organization balance" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  test "html with targeted keywords and country but $0 organization balance" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and undetectable country prefers targeted fallback" do
    campaigns(:fallback).update start_date: @campaign.start_date, end_date: @campaign.end_date
    copy! campaigns(:fallback),
      keywords: @campaign.keywords.sample(2),
      creative: copy!(campaigns(:fallback).creative, body: "This is a targeted fallback campaign")
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert Campaign.fallback.count == 2
    assert response.status == 200
    assert response.body =~ /This is a targeted fallback campaign/
    assert response.body =~ /house: true/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and undetectable country with untargeted fallback" do
    campaigns(:fallback).update start_date: @campaign.start_date, end_date: @campaign.end_date
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /This is a fallback campaign/
    assert response.body =~ /house: true/
  end

  test "javascript with targeted country and untargeted keywords with untargeted fallback" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    campaigns(:fallback).update start_date: @campaign.start_date, end_date: @campaign.end_date
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /This is a fallback campaign/
    assert response.body =~ /house: true/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /house: false/
  end

  test "json with targeted keywords and country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /campaignUrl/
    assert response.body =~ /impressionUrl/
  end

  test "html with targeted keywords and country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /<div id=\"cf\"/
  end

  private

  def ip_address(country_code)
    attempts = 0
    ip = Faker::Internet.public_ip_v4_address
    data = MMDB.lookup(ip) || {}
    while data.to_hash.dig("country", "iso_code") != country_code
      data = MMDB.lookup(ip = Faker::Internet.public_ip_v4_address) || {}
      attempts += 1
      puts "#{attempts} attempts to find IP address for: #{country_code}" if attempts % 20 == 0
    end
    ip
  end
end
