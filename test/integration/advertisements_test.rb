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
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json with targeted keywords and undetectable country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html with targeted keywords and undetectable country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted country and untargeted keywords" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json with targeted country and untargeted keywords" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html with targeted country and untargeted keywords" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @campaign.keywords
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and untargeted country" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json with targeted keywords and untargeted country" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html with targeted keywords and untargeted country" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and country but $0 organization balance" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json with targeted keywords and country but $0 organization balance" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html with targeted keywords and country but $0 organization balance" do
    @campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with targeted keywords and country prefers targeted fallback when premium not available" do
    campaigns(:fallback).update start_date: @campaign.start_date, end_date: @campaign.end_date
    copy! campaigns(:fallback),
      keywords: @campaign.keywords.sample(2),
      creative: copy!(campaigns(:fallback).creative, body: "This is a targeted fallback campaign")
    @campaign.update keywords: ["No Match"]
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

  # ----------------------------------------------------------------------------------------------------------

  test "javascript with assigned property" do
    copy! @campaign,
      assigned_property_ids: [@property.id],
      keywords: [],
      creative: copy!(@campaign.creative, body: "This is an assigned premium campaign")

    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.premium.count == 2
    assert response.status == 200
    assert response.body =~ /This is an assigned premium campaign/
    assert response.body =~ /house: false/
  end

  test "javascript with assigned property only shows for assigned properties" do
    @campaign.update assigned_property_ids: [@property.id]
    property = copy!(@property)
    get advertisements_path(property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "javascript with assigned property does not show for untargeted country" do
    @campaign.update assigned_property_ids: [@property.id]
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "javascript with assigned property without budget shows targeted premium" do
    user = copy! users(:advertiser),
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password",
      organization: copy!(organizations(:default), balance: Money.new(0, "USD"))
    copy! @campaign,
      user: user,
      assigned_property_ids: [@property.id],
      keywords: [],
      creative: copy!(@campaign.creative, body: "This is an assigned premium campaign")

    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.premium.count == 2
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /house: false/
  end
end
