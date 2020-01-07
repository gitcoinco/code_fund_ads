require_relative "system_test_helper"

class AdsBottomBarJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "bottom-bar")
  end

  teardown do
    travel_back
  end

  test "bottom bar - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "10px 20px 12px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "1px",
                                                           "border-top-color": "rgba(191, 191, 191, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(238, 238, 238, 1)",
                                                           "text-align": "left",
                                                           "line-height": "24px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(0, 0, 0, 0.6)",
                                                     "text-decoration": "none solid rgba(0, 0, 0, 0.6)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "color": "rgba(0, 0, 0, 0.5)",)
  end

  test "bottom bar - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "10px 20px 12px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "1px",
                                                           "border-top-color": "rgba(191, 191, 191, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(238, 238, 238, 1)",
                                                           "text-align": "left",
                                                           "line-height": "24px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(0, 0, 0, 0.8)",
                                                     "text-decoration": "none solid rgba(0, 0, 0, 0.8)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "color": "rgba(0, 0, 0, 0.5)",)
  end

  test "bottom bar - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "10px 20px 12px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "1px",
                                                           "border-top-color": "rgba(191, 191, 191, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(238, 238, 238, 1)",
                                                           "text-align": "left",
                                                           "line-height": "24px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(0, 0, 0, 0.6)",
                                                     "text-decoration": "none solid rgba(0, 0, 0, 0.6)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "color": "rgba(0, 0, 0, 0.5)",)
  end

  test "bottom bar - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "10px 20px 12px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "1px",
                                                           "border-top-color": "rgba(191, 191, 191, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(238, 238, 238, 1)",
                                                           "text-align": "left",
                                                           "line-height": "24px",)
    find("a", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                     "color": "rgba(0, 0, 0, 0.8)",
                                                     "text-decoration": "none solid rgba(0, 0, 0, 0.8)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "11px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "color": "rgba(0, 0, 0, 0.5)",)
  end
end
