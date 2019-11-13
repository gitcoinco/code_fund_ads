require_relative "system_test_helper"

class AdsDefaultJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "default")
  end

  teardown do
    travel_back
  end

  test "default - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("font-family": "\"Times New Roman\"", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "content-box",
                                                           "padding": "15px",
                                                           "position": "static",
                                                           "width": "300px",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "text-align": "left",
                                                           "line-height": "19.6px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 238)",
                                                             "color": "rgba(0, 0, 238, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(51, 51, 51, 1)",
                                                        "text-decoration": "none solid rgb(51, 51, 51)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgb(119, 119, 119)",
                                                           "color": "rgba(119, 119, 119, 1)",)
  end

  test "default - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("font-family": "\"Times New Roman\"", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "content-box",
                                                           "padding": "15px",
                                                           "position": "static",
                                                           "width": "300px",
                                                           "background-color": "rgba(0, 0, 0, 0)",
                                                           "text-align": "left",
                                                           "line-height": "19.6px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 238)",
                                                             "color": "rgba(0, 0, 238, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(255, 255, 255, 0.7)",
                                                        "text-decoration": "none solid rgba(255, 255, 255, 0.7)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.7)",
                                                           "color": "rgba(255, 255, 255, 0.7)",)
  end

  test "fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("font-family": "\"Times New Roman\"", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "content-box",
                                                           "padding": "15px",
                                                           "position": "static",
                                                           "width": "300px",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "text-align": "left",
                                                           "line-height": "19.6px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 238)",
                                                             "color": "rgba(0, 0, 238, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(51, 51, 51, 1)",
                                                        "text-decoration": "none solid rgb(51, 51, 51)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgb(119, 119, 119)",
                                                           "color": "rgba(119, 119, 119, 1)",)
  end

  test "default - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("font-family": "\"Times New Roman\"", "font-size": "16px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "content-box",
                                                           "padding": "15px",
                                                           "position": "static",
                                                           "width": "300px",
                                                           "background-color": "rgba(0, 0, 0, 0)",
                                                           "text-align": "left",
                                                           "line-height": "19.6px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 238)",
                                                             "color": "rgba(0, 0, 238, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(255, 255, 255, 0.7)",
                                                        "text-decoration": "none solid rgba(255, 255, 255, 0.7)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.7)",
                                                           "color": "rgba(255, 255, 255, 0.7)",)
  end
end
