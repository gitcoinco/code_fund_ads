require "test_helper"

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  test "get advertisement" do
    campaign = active_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :json)
    assert_response :success
  end

  private

  def active_campaign
    campaign = campaigns(:exclusive)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ACTIVE,
      start_date: 1.month.ago,
      end_date: 1.month.from_now,
      keywords: ENUMS::KEYWORDS.values.sample(10)
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
