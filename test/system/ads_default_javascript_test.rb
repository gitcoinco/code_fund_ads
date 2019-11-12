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

    find("div", id: "cf").assert_matches_style('font-family': "Helvetica, Arial, sans-serif", "font-size": "14px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "11.2px 14px 14px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "2px",
                                                           "border-top-color": "rgba(76, 175, 80, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(238, 238, 238, 1)",
                                                           "text-align": "center",
                                                           "line-height": "21px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 0)",
                                                             "color": "rgba(0, 0, 0, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(0, 0, 0, 1)",
                                                        "text-decoration": "none solid rgb(0, 0, 0)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgb(153, 153, 153)",
                                                           "color": "rgba(153, 153, 153, 1)",)
  end

  test "default - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "Helvetica, Arial, sans-serif", "font-size": "14px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "11.2px 14px 14px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "2px",
                                                           "border-top-color": "rgba(76, 175, 80, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(239, 239, 239, 1)",
                                                           "text-align": "center",
                                                           "line-height": "21px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 0)",
                                                             "color": "rgba(0, 0, 0, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(0, 0, 0, 1)",
                                                        "text-decoration": "none solid rgb(0, 0, 0)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgb(153, 153, 153)",
                                                           "color": "rgba(153, 153, 153, 1)",)
  end

  test "fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "Helvetica, Arial, sans-serif", "font-size": "14px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "11.2px 14px 14px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "2px",
                                                           "border-top-color": "rgba(76, 175, 80, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(238, 238, 238, 1)",
                                                           "text-align": "center",
                                                           "line-height": "21px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 0)",
                                                             "color": "rgba(0, 0, 0, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(0, 0, 0, 1)",
                                                        "text-decoration": "none solid rgb(0, 0, 0)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgb(153, 153, 153)",
                                                           "color": "rgba(153, 153, 153, 1)",)
  end

  test "default - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style('font-family': "Helvetica, Arial, sans-serif", "font-size": "14px")
    find("span", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                           "padding": "11.2px 14px 14px",
                                                           "position": "fixed",
                                                           "bottom": "0px",
                                                           "left": "0px",
                                                           "z-index": "5000",
                                                           "width": "1400px",
                                                           "border-top-width": "2px",
                                                           "border-top-color": "rgba(76, 175, 80, 1)",
                                                           "border-top-style": "solid",
                                                           "background-color": "rgba(239, 239, 239, 1)",
                                                           "text-align": "center",
                                                           "line-height": "21px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none",
                                                             "text-decoration": "none solid rgb(0, 0, 0)",
                                                             "color": "rgba(0, 0, 0, 1)",)
    find("span", class: "cf-text").assert_matches_style("box-shadow": "none",
                                                        "color": "rgba(0, 0, 0, 1)",
                                                        "text-decoration": "none solid rgb(0, 0, 0)",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "font-size": "12px",
                                                           "text-decoration": "none solid rgb(153, 153, 153)",
                                                           "color": "rgba(153, 153, 153, 1)",)
  end
end
