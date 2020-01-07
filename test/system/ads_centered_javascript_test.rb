require_relative "system_test_helper"

class AdsCenteredJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "centered")
  end

  teardown do
    travel_back
  end

  test "centered - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "This is a premium campaign ethical ad by CodeFund")

    assert_selector("div#cf")
    find("div", class: "cf-wrapper").assert_matches_style("max-width": "330px",
                                                          "padding-top": "15px",
                                                          "display": "block",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "margin": "0px 512px",)
    find("div", class: "cf-header").assert_matches_style("font-size": "12px",
                                                         "color": "rgba(102, 119, 136, 1)",
                                                         "display": "block",
                                                         "margin-bottom": "8px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(51, 51, 51, 1)",
                                                     "text-decoration": "none solid rgb(51, 51, 51)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgb(102, 119, 136)",
                                                           "display": "block",
                                                           "text-align": "center",
                                                           "color": "rgba(102, 119, 136, 1)",)
  end

  test "centered - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "This is a premium campaign ethical ad by CodeFund")

    assert_selector("div#cf")
    find("div", class: "cf-wrapper").assert_matches_style("max-width": "330px",
                                                          "padding-top": "15px",
                                                          "display": "block",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "margin": "0px 512px",)
    find("div", class: "cf-header").assert_matches_style("font-size": "12px",
                                                         "color": "rgba(255, 255, 255, 0.8)",
                                                         "display": "block",
                                                         "margin-bottom": "8px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(255, 255, 255, 1)",
                                                     "text-decoration": "none solid rgb(255, 255, 255)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.6)",
                                                           "display": "block",
                                                           "text-align": "center",
                                                           "color": "rgba(255, 255, 255, 0.6)",)
  end

  test "centered - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "This is a fallback campaign ethical ad by CodeFund")

    assert_selector("div#cf")
    find("div", class: "cf-wrapper").assert_matches_style("max-width": "330px",
                                                          "padding-top": "15px",
                                                          "display": "block",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "margin": "0px 512px",)
    find("div", class: "cf-header").assert_matches_style("font-size": "12px",
                                                         "color": "rgba(102, 119, 136, 1)",
                                                         "display": "block",
                                                         "margin-bottom": "8px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(51, 51, 51, 1)",
                                                     "text-decoration": "none solid rgb(51, 51, 51)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgb(102, 119, 136)",
                                                           "display": "block",
                                                           "text-align": "center",
                                                           "color": "rgba(102, 119, 136, 1)",)
  end

  test "centered - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "This is a fallback campaign ethical ad by CodeFund")

    assert_selector("div#cf")
    find("div", class: "cf-wrapper").assert_matches_style("max-width": "330px",
                                                          "padding-top": "15px",
                                                          "display": "block",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "margin": "0px 512px",)
    find("div", class: "cf-header").assert_matches_style("font-size": "12px",
                                                         "color": "rgba(255, 255, 255, 0.8)",
                                                         "display": "block",
                                                         "margin-bottom": "8px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(255, 255, 255, 1)",
                                                     "text-decoration": "none solid rgb(255, 255, 255)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.6)",
                                                           "display": "block",
                                                           "text-align": "center",
                                                           "color": "rgba(255, 255, 255, 0.6)",)
  end
end
