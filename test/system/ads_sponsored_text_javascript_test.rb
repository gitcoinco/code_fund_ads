require_relative "system_test_helper"

class AdsSponsoredTextJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "sponsored-text")
  end

  teardown do
    travel_back
  end

  test "sponsored text - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a premium campaign Premium ethical ad by CodeFund")

    find("ins", id: "cf").assert_matches_style("text-decoration": "none solid rgb(108, 117, 126)",
                                               "color": "rgba(108, 117, 126, 1)",
                                               "line-height": "23.8px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "14px",
                                               "font-weight": "400",)
    assert_selector("span.cf-wrapper")
    assert_selector("sup")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "position": "static",
                                                    "display": "inline",)
  end

  test "sponsored text - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a premium campaign Premium ethical ad by CodeFund")

    find("ins", id: "cf").assert_matches_style("text-decoration": "none solid rgb(170, 170, 170)",
                                               "color": "rgba(170, 170, 170, 1)",
                                               "line-height": "23.8px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "14px",
                                               "font-weight": "400",)
    assert_selector("span.cf-wrapper")
    assert_selector("sup")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "position": "static",
                                                    "display": "inline",)
  end

  test "sponsored text - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a fallback campaign Fallback ethical ad by CodeFund")

    find("ins", id: "cf").assert_matches_style("text-decoration": "none solid rgb(108, 117, 126)",
                                               "color": "rgba(108, 117, 126, 1)",
                                               "line-height": "23.8px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "14px",
                                               "font-weight": "400",)
    assert_selector("span.cf-wrapper")
    assert_selector("sup")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "position": "static",
                                                    "display": "inline",)
  end

  test "sponsored text - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a fallback campaign Fallback ethical ad by CodeFund")

    find("ins", id: "cf").assert_matches_style("text-decoration": "none solid rgb(170, 170, 170)",
                                               "color": "rgba(170, 170, 170, 1)",
                                               "line-height": "23.8px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "14px",
                                               "font-weight": "400",)
    assert_selector("span.cf-wrapper")
    assert_selector("sup")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "position": "static",
                                                    "display": "inline",)
  end
end
