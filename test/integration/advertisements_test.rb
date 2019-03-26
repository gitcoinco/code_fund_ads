require "test_helper"
require "faker"

class AdvertisementsTest < ActionDispatch::IntegrationTest
  setup do
    @premium_campaign = campaigns(:premium)
    @premium_campaign.update start_date: Date.parse("2019-01-01"), end_date: Date.parse("2019-04-01"), keywords: ENUMS::KEYWORDS.keys.sample(5)
    @property = properties(:website)
    @property.update keywords: @premium_campaign.keywords.sample(3)
    travel_to @premium_campaign.start_date.to_time.advance(days: 15)
  end

  teardown do
    travel_back
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: campaign with matching keywords will not display when country is unknown" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json: campaign with matching keywords will not display when country is unknown" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html: campaign with matching keywords will not display when country is unknown" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: campaign with matching country will not display when keywords don't match" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @premium_campaign.keywords
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json: campaign with matching country will not display when keywords don't match" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @premium_campaign.keywords
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html: campaign with matching country will not display when keywords don't match" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @premium_campaign.keywords
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: campaign with matching keywords will not display when country doesn't match" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json: campaign with matching keywords will not display when country doesn't match" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html: campaign with matching keywords will not display when country doesn't match" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: campaign with matching keywords and country will not display when organization has a $0 balance" do
    @premium_campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "json: campaign with matching keywords and country will not display when organization has a $0 balance" do
    @premium_campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "html: campaign with matching keywords and country will not display when organization has a $0 balance" do
    @premium_campaign.organization.update balance: Money.new(0, "USD")
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 404
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: fallback campaign with matching keywords and country is displayed before generic fallback campaigns" do
    campaigns(:fallback).update start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
    copy! campaigns(:fallback),
      keywords: @property.keywords.sample(2),
      creative: copy!(campaigns(:fallback).creative, body: "This is a targeted fallback campaign")
    @premium_campaign.update keywords: ["No Match"]
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.fallback.count == 2
    assert response.status == 200
    assert response.body =~ /This is a targeted fallback campaign/
    assert response.body =~ /house: true/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: fallback campaign is displayed even when premium campaign with matching keywords exists but country is unknown" do
    campaigns(:fallback).update start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /This is a fallback campaign/
    assert response.body =~ /house: true/
  end

  test "js: fallback campaign is displayed even when premium campaign with matching country exists but keywords don't match" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @premium_campaign.keywords
    campaigns(:fallback).update start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a fallback campaign/
    assert response.body =~ /house: true/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: campaign with targeted keywords and country will display" do
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /house: false/
  end

  test "json: campaign with targeted keywords and country will display" do
    get advertisements_path(@property, format: :json), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /campaignUrl/
    assert response.body =~ /impressionUrl/
  end

  test "html: campaign with targeted keywords and country will display" do
    get advertisements_path(@property, format: :html), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /<div id=\"cf\"/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: campaign with assigned property will eventually display" do
    copy! @premium_campaign
    @premium_campaign.update assigned_property_ids: [@property.id]
    @premium_campaign.creative.update body: "This is a premium campaign assigned to the property"
    100.times.each do
      get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
      break if response.body.include?(@premium_campaign.creative.body)
    end
    assert response.status == 200
    assert response.body.include?(@premium_campaign.creative.body)
  end

  test "js: campaign with assigned property does not display on unassigned properties" do
    @premium_campaign.update assigned_property_ids: [@property.id]
    property = copy!(@property)
    get advertisements_path(property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "js: campaign with assigned property does not show for untargeted country" do
    @premium_campaign.update assigned_property_ids: [@property.id]
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("CN")}
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  test "js: property will show targeted premium campaign over a zero balance campaign with assigned property" do
    user = copy! users(:advertiser),
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password",
      organization: copy!(organizations(:default), balance: Money.new(0, "USD"))
    copy! @premium_campaign,
      user: user,
      assigned_property_ids: [@property.id],
      keywords: [],
      creative: copy!(@premium_campaign.creative, body: "This is an assigned premium campaign")

    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.premium.count == 2
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /house: false/
  end
end
