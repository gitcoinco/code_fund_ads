require "test_helper"
require "faker"

class AdvertisementsTest < ActionDispatch::IntegrationTest
  setup do
    @campaign = campaigns(:default)
    @campaign.update start_date: Date.parse("2019-01-01"), end_date: Date.parse("2019-04-01"), keywords: ENUMS::KEYWORDS.keys.sample(5)
    @property = properties(:website)
    @property.update keywords: @campaign.keywords.sample(2)
    travel_to @campaign.start_date.to_time.advance(days: 15)
  end

  teardown do
    travel_back
  end

  test "advertisement javascript with undetectable country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time\./i
  end

  test "advertisement json with undetectable country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time\./i
  end

  test "advertisement html with undetectable country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have a advertiser for you at this time\./i
  end

  test "advertisement javascript with targeted country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /targetElement\.innerHTML =/i
  end

  test "advertisement json with targeted country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /campaignUrl/
    assert response.body =~ /impressionUrl/
  end

  test "advertisement html with targeted country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /<div id=\"cf\"/i
  end

  test "advertisement javascript with untargeted country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time\./i
  end

  test "advertisement javascript with $0 organization budget" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have a advertiser for you at this time\./i
  end

  private

  def ip_address(country_code)
    attempts = 0
    ip = Faker::Internet.public_ip_v4_address
    data = MMDB.lookup(ip) || {}
    while data.to_hash.dig("country", "iso_code") != country_code
      data = MMDB.lookup(ip = Faker::Internet.public_ip_v4_address) || {}
      attempts += 1
      puts "Generating IP address for: #{country_code}" if attempts % 10 == 0
    end
    ip
  end
end
