require "application_system_test_case"

module SystemTestHelper
  def assert_campaign_link(campaign)
    assert_css "a[data-href='campaign_url'][href*='click?campaign_id=#{campaign.id}'][target='_blank'][rel='nofollow noopener']"
  end

  def assert_impression_pixel(property)
    assert_css "img[data-src='impression_url'][src*='/display/']"
  end

  def assert_powered_by_link
    assert_css "a[data-target='powered_by_url'][href][target='_blank'][rel='nofollow noopener']"
    assert_text :all, "ethical ad by CodeFund"
  end

  def assert_creative_headline(campaign)
    assert campaign.creative.headline.present?
    assert_text campaign.creative.headline
  end

  def assert_creative_body(campaign)
    assert campaign.creative.body.present?
    assert_text campaign.creative.body
  end
end
