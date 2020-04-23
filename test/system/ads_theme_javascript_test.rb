require_relative "system_test_helper"

class AdsThemeJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "default")
  end

  teardown do
    travel_back
  end

  test "correct assets are loaded for light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_css "link[href*='#{Webpacker.manifest.lookup("code_fund_ad.css")}'][id='codefund-style'][rel='stylesheet'][media='all']"
    assert_css "script[src*='#{Webpacker.manifest.lookup("code_fund_ad.js")}'][id='codefund-script'][type='text/javascript']"
  end

  test "correct assets are loaded for dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_css "link[href*='#{Webpacker.manifest.lookup("code_fund_ad.css")}'][id='codefund-style'][rel='stylesheet'][media='all']"
    assert_css "script[src*='#{Webpacker.manifest.lookup("code_fund_ad.js")}'][id='codefund-script'][type='text/javascript']"
  end

  test "correct assets are loaded for unstyled theme" do
    @property.update ad_theme: "unstyled"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_no_css "link[href*='#{Webpacker.manifest.lookup("code_fund_ad.css")}'][id='codefund-style'][rel='stylesheet'][media='all']"
    assert_css "script[src*='#{Webpacker.manifest.lookup("code_fund_ad.js")}'][id='codefund-script'][type='text/javascript']"
  end
end
