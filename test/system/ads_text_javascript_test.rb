require_relative "system_test_helper"

class AdsTextJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "text")
  end

  teardown do
    travel_back
  end

  test "text - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign

    find("div", id: "cf").assert_matches_style("text-decoration": "none solid rgb(119, 131, 143)",
                                               "color": "rgba(119, 131, 143, 1)",
                                               "line-height": "22px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "13px",
                                               "box-shadow": "none")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "cursor": "pointer",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                    "font-size": "13px",
                                                    "line-height": "22px",
                                                    "box-shadow": "none",)
  end

  test "text - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign

    find("div", id: "cf").assert_matches_style("text-decoration": "none solid rgb(119, 131, 143)",
                                               "color": "rgba(119, 131, 143, 1)",
                                               "line-height": "22px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "13px",
                                               "box-shadow": "none")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "cursor": "pointer",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                    "font-size": "13px",
                                                    "line-height": "22px",
                                                    "box-shadow": "none",)
  end

  test "text - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign

    find("div", id: "cf").assert_matches_style("text-decoration": "none solid rgb(119, 131, 143)",
                                               "color": "rgba(119, 131, 143, 1)",
                                               "line-height": "22px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "13px",
                                               "box-shadow": "none")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "cursor": "pointer",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                    "font-size": "13px",
                                                    "line-height": "22px",
                                                    "box-shadow": "none",)
  end

  test "text - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign

    find("div", id: "cf").assert_matches_style("text-decoration": "none solid rgb(119, 131, 143)",
                                               "color": "rgba(119, 131, 143, 1)",
                                               "line-height": "22px",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "font-size": "13px",
                                               "box-shadow": "none")
    find("a", class: "cf-cta").assert_matches_style("color": "rgba(52, 152, 219, 1)",
                                                    "cursor": "pointer",
                                                    "text-decoration": "none solid rgb(52, 152, 219)",
                                                    "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                    "font-size": "13px",
                                                    "line-height": "22px",
                                                    "box-shadow": "none",)
  end
end
