require "application_system_test_case"

module SystemTestHelper
  def assert_campaign_link(campaign)
    assert_css "a[href*='click?campaign_id=#{campaign.id}'][target='_blank'][rel='sponsored noopener']"
  end

  def assert_impression_pixel(property)
    assert_selector("img.cf-impression")
  end

  def assert_powered_by_link(text: "ethical ads by CodeFund")
    assert_css "a[href][class='cf-powered-by'][target='_blank'][rel='sponsored noopener']"
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
    Capybara.ignore_hidden_elements = false
    AdvertisementsController.any_instance.stubs(ad_test?: false)

    @premium_campaign = amend campaigns: :premium_bundled
    @premium_campaign.organization.update balance: Monetize.parse("$10,000 USD")
    @fallback_campaign = amend campaigns: :fallback
    @property = matched_property(@premium_campaign)
    @property.update! ad_template: ad_template, ad_theme: ad_theme
  end
end
