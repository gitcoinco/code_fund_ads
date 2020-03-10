require_relative "system_test_helper"

class AdsHorizontalJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "horizontal")
  end

  teardown do
    travel_back
  end

  test "horizontal - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a premium campaign Premium ethical ad by CodeFund")

    assert_selector("div#cf")
    find("span", class: "cf-wrapper").assert_matches_style("background-color": "rgb(248, 248, 248)",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "font-size": "14px",
                                                           "line-height": "21px",
                                                           "padding": "12px 11px",
                                                           "text-align": "left",
                                                           "width": "1384px",
                                                           "z-index": "auto",
                                                           "box-sizing": "border-box",
                                                           "display": "block",
                                                           "margin": "12px 0px")
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(0, 0, 0, 0.6)",
                                                     "text-decoration": "none solid rgba(0, 0, 0, 0.6)",
                                                     "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "color": "rgba(0, 0, 0, 0.5)",
                                                           "float": "right")
  end

  test "horizontal - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a premium campaign Premium ethical ad by CodeFund")

    assert_selector("div#cf")
    find("span", class: "cf-wrapper").assert_matches_style("background-color": "rgba(255, 255, 255, 0.2)",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "font-size": "14px",
                                                           "line-height": "21px",
                                                           "padding": "12px 11px",
                                                           "text-align": "left",
                                                           "width": "1384px",
                                                           "z-index": "auto",
                                                           "box-sizing": "border-box",
                                                           "display": "block",
                                                           "margin": "12px 0px")
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(255, 255, 255, 0.7)",
                                                     "text-decoration": "none solid rgba(255, 255, 255, 0.7)",
                                                     "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.5)",
                                                           "color": "rgba(255, 255, 255, 0.5)",
                                                           "float": "right")
  end

  test "horizontal - fallback ad with light theme" do
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a fallback campaign Fallback ethical ad by CodeFund")

    assert_selector("div#cf")
    find("span", class: "cf-wrapper").assert_matches_style("background-color": "rgb(248, 248, 248)",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "font-size": "14px",
                                                           "line-height": "21px",
                                                           "padding": "12px 11px",
                                                           "text-align": "left",
                                                           "width": "1384px",
                                                           "z-index": "auto",
                                                           "box-sizing": "border-box",
                                                           "display": "block",
                                                           "margin": "12px 0px")
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(0, 0, 0, 0.6)",
                                                     "text-decoration": "none solid rgba(0, 0, 0, 0.6)",
                                                     "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "color": "rgba(0, 0, 0, 0.5)",
                                                           "float": "right")
  end

  test "horizontal - fallback ad with dark theme" do
    @property.update ad_theme: "dark"
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a fallback campaign Fallback ethical ad by CodeFund")

    assert_selector("div#cf")
    find("span", class: "cf-wrapper").assert_matches_style("background-color": "rgba(255, 255, 255, 0.2)",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "font-size": "14px",
                                                           "line-height": "21px",
                                                           "padding": "12px 11px",
                                                           "text-align": "left",
                                                           "width": "1384px",
                                                           "z-index": "auto",
                                                           "box-sizing": "border-box",
                                                           "display": "block",
                                                           "margin": "12px 0px")
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(255, 255, 255, 0.7)",
                                                     "text-decoration": "none solid rgba(255, 255, 255, 0.7)",
                                                     "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.5)",
                                                           "color": "rgba(255, 255, 255, 0.5)",
                                                           "float": "right")
  end
end
