require "test_helper"
require "faker"

class AdvertisementsTest < ActionDispatch::IntegrationTest
  setup do
    start_date = Date.parse("2019-01-01")
    @premium_campaign = amend campaigns: :premium,
                              start_date: start_date,
                              end_date: start_date.advance(months: 3),
                              keywords: ENUMS::KEYWORDS.keys.sample(5)
    @property = amend properties: :website, keywords: @premium_campaign.keywords.sample(3)
    travel_to start_date.to_time.advance(days: 15)
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
    amend campaigns: :fallback, start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
    copy campaigns: :fallback, keywords: @property.keywords.sample(2),
         creative: copy(creatives: :fallback, body: "This is a targeted fallback campaign")
    @premium_campaign.update keywords: ["No Match"]
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.fallback.count == 2
    assert response.status == 200
    assert response.body =~ /This is a targeted fallback campaign/
    assert response.body =~ /house: true/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: fallback campaign is displayed even when premium campaign with matching keywords exists but country is unknown" do
    amend campaigns: :fallback, start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": "0.0.0.0"}
    assert response.status == 200
    assert response.body =~ /This is a fallback campaign/
    assert response.body =~ /house: true/
  end

  test "js: fallback campaign is displayed even when premium campaign with matching country exists but keywords don't match" do
    @property.update keywords: ENUMS::KEYWORDS.keys.sample(5) - @premium_campaign.keywords
    amend campaigns: :fallback, start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
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

  test "js: property with assigner campaign will eventually display the assigner campaign" do
    other_campaign = copy(campaigns: :premium, creative: copy(creatives: :premium))
    @premium_campaign.update assigned_property_ids: [@property.id]
    @premium_campaign.creative.update body: "This is a premium campaign that has assigned the property"
    assert other_campaign.creative.body != @premium_campaign.creative.body
    100.times.each do
      get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
      break if response.body.include?(@premium_campaign.creative.body)
    end
    assert response.status == 200
    assert response.body.include?(@premium_campaign.creative.body)
  end

  test "js: property with assigner campaign will eventually display other matching campaigns" do
    other_campaign = copy(campaigns: :premium, creative: copy(creatives: :premium, body: "This is a non assigner premium campaign"))
    @premium_campaign.update assigned_property_ids: [@property.id]
    @premium_campaign.creative.update body: "This is a premium campaign that has assigned the property"
    assert other_campaign.creative.body != @premium_campaign.creative.body
    100.times.each do
      get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
      break if response.body.include?(other_campaign.creative.body)
    end
    assert response.status == 200
    assert response.body.include?(other_campaign.creative.body)
  end

  test "js: property with assigner campaign will never display other matching campaigns when restrict_to_assigner_campaigns is true" do
    other_campaign = copy(campaigns: :premium, creative: copy(creatives: :premium))
    @premium_campaign.update assigned_property_ids: [@property.id]
    @premium_campaign.creative.update body: "This is a premium campaign that has assigned the property"
    @property.update restrict_to_assigner_campaigns: true
    assert other_campaign.creative.body != @premium_campaign.creative.body
    100.times.each do
      get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
      assert response.status == 200
      assert response.body.include?(@premium_campaign.creative.body)
    end
  end

  test "js: campaign with assigned property does not display on unassigned properties" do
    @premium_campaign.update assigned_property_ids: [@property.id]
    property = copy(properties: :website)
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
    user = copy users: :advertiser,
                email: Faker::Internet.email,
                password: "password",
                password_confirmation: "password",
                organization: copy(organizations: :default, balance: Money.new(0, "USD"))

    copy campaigns: :premium,
         user: user,
         assigned_property_ids: [@property.id],
         keywords: [],
         creative: copy(creatives: :premium, body: "This is an assigned premium campaign")

    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.premium.count == 2
    assert response.status == 200
    assert response.body =~ /This is a premium campaign/
    assert response.body =~ /house: false/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: property only shows assigned fallback" do
    @premium_campaign.update status: ENUMS::CAMPAIGN_STATUSES::PENDING

    amend campaigns: :fallback,
          keywords: @property.keywords,
          start_date: @premium_campaign.start_date,
          end_date: @premium_campaign.end_date,
          creative: copy(creatives: :fallback, body: "This is a targeted fallback campaign")

    assigned = copy campaigns: :fallback, keywords: [],
                    creative: copy(creatives: :fallback, body: "This is an assigned fallback campaign")

    @property.update assigned_fallback_campaign_ids: [assigned.id]

    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.fallback.count == 2
    assert response.status == 200
    assert response.body =~ /This is an assigned fallback campaign/
    assert response.body =~ /house: true/
  end

  test "js: property prefers targeted assigned fallbacks" do
    @premium_campaign.update status: ENUMS::CAMPAIGN_STATUSES::PENDING

    amend campaigns: :fallback,
          keywords: @property.keywords,
          start_date: @premium_campaign.start_date,
          end_date: @premium_campaign.end_date,
          creative: copy(creatives: :fallback, body: "This is a targeted fallback campaign")

    assigned = copy campaigns: :fallback, keywords: [],
                    creative: copy(creatives: :fallback, body: "This is an assigned fallback campaign")

    assigned_and_targeted = copy campaigns: :fallback, keywords: @property.keywords,
                                 creative: copy(creatives: :fallback, body: "This is an assigned and targeted fallback campaign")

    @property.update assigned_fallback_campaign_ids: [assigned.id, assigned_and_targeted.id]

    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Campaign.fallback.count == 3
    assert response.status == 200
    assert response.body =~ /This is an assigned and targeted fallback campaign/
    assert response.body =~ /house: true/
  end

  test "js: fallback campaign with assigned property will not display on a different property even if the different property assigns the fallback campaign" do
    @premium_campaign.update status: ENUMS::CAMPAIGN_STATUSES::PENDING

    fallback_campaign = amend campaigns: :fallback,
                              start_date: @premium_campaign.start_date,
                              end_date: @premium_campaign.end_date,
                              assigned_property_ids: [@property.id],
                              creative: copy(creatives: :fallback, body: "This is a fallback campaign assigned to a different property")

    other_property = copy properties: :website, assigned_fallback_campaign_ids: [fallback_campaign.id]

    get advertisements_path(other_property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert Property.website.count == 2
    assert response.status == 200
    assert response.body =~ /CodeFund does not have an advertiser for you at this time/
  end

  # ----------------------------------------------------------------------------------------------------------

  test "js: premium ads render with property preferred template and theme" do
    @property.update ad_template: "horizontal", ad_theme: "dark"
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body.include?("template=horizontal&theme=dark")
    assert response.body =~ /house: false/
  end

  test "js: fallback ads with property preferred fallback template and fallback theme" do
    amend campaigns: :fallback, start_date: @premium_campaign.start_date, end_date: @premium_campaign.end_date
    @premium_campaign.update keywords: []
    @property.update fallback_ad_template: "text", fallback_ad_theme: "light"
    get advertisements_path(@property, format: :js), headers: {"REMOTE_ADDR": ip_address("US")}
    assert response.status == 200
    assert response.body.include?("template=text&theme=light")
    assert response.body =~ /house: true/
  end
end
