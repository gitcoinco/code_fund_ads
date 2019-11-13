require "application_system_test_case"

module SystemTestHelper
  def assert_campaign_link(campaign)
    assert_css "a[data-href='campaign_url'][href*='click?campaign_id=#{campaign.id}'][target='_blank'][rel='sponsored noopener']"
  end

  def assert_impression_pixel(property)
    assert_css "img[data-src='impression_url'][src*='/display/']"
  end

  def assert_powered_by_link(text: "ethical ad by CodeFund")
    assert_css "a[data-target='powered_by_url'][href][target='_blank'][rel='sponsored noopener']"
    assert_text :all, text
  end

  def assert_creative_headline(campaign)
    assert campaign.creative.headline.present?
    assert_text campaign.creative.headline
  end

  def assert_creative_body(campaign)
    assert campaign.creative.body.present?
    assert_text campaign.creative.body
  end

  def ad_template_setup(ad_template: "default", ad_theme: "light")
    AdvertisementsController.any_instance.stubs(ad_test?: false)

    start_date = Date.parse("2019-01-01")
    @premium_campaign = amend campaigns: :premium,
                              start_date: start_date,
                              end_date: start_date.advance(months: 3),
                              keywords: ENUMS::KEYWORDS.keys.sample(5)
    @premium_campaign.organization.update balance: Monetize.parse("$10,000 USD")
    @fallback_campaign = amend campaigns: :fallback,
                               start_date: @premium_campaign.start_date,
                               end_date: @premium_campaign.end_date
    @property = amend properties: :website,
                      keywords: @premium_campaign.keywords.sample(3),
                      ad_template: ad_template,
                      ad_theme: ad_theme
    travel_to start_date.to_time.advance(days: 15)
  end
end
