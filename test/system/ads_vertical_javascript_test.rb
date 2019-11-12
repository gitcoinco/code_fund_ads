require_relative "system_test_helper"

class AdsVerticalJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "vertical")
    Creative.any_instance.stubs(small_image: OpenStruct.new(cloudfront_url: "https://www.test.codefund.io/test.png"))
  end

  teardown do
    travel_back
  end

  test "vertical - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "ads by CodeFund")

    find("div", id: "cf").assert_matches_style("margin-top": "0px",
                                               "margin-left": "629.5px",
                                               "background-color": "rgba(0, 0, 0, 0)",
                                               "width": "125px",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "margin-bottom": "8px",)
    find("img", class: "cf-img").assert_matches_style("width": "72.0156px",
                                                      "position": "relative",
                                                      "height": "19px",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(62, 62, 62, 1)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgb(170, 170, 170)",
                                                           "font-size": "12px",
                                                           "display": "block",
                                                           "color": "rgba(170, 170, 170, 1)",
                                                           "margin-top": "10px",)
  end

  test "vertical - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "ads by CodeFund")

    find("div", id: "cf").assert_matches_style("margin-top": "0px",
                                               "margin-left": "629.5px",
                                               "background-color": "rgba(0, 0, 0, 0)",
                                               "width": "125px",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "margin-bottom": "8px",)
    find("img", class: "cf-img").assert_matches_style("width": "72.0156px",
                                                      "position": "relative",
                                                      "height": "19px",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(255, 255, 255, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.6)",
                                                           "font-size": "12px",
                                                           "display": "block",
                                                           "color": "rgba(255, 255, 255, 0.6)",
                                                           "margin-top": "10px",)
  end

  test "vertical - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "ads by CodeFund")

    find("div", id: "cf").assert_matches_style("margin-top": "0px",
                                               "margin-left": "629.5px",
                                               "background-color": "rgba(0, 0, 0, 0)",
                                               "width": "125px",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "margin-bottom": "8px",)
    find("img", class: "cf-img").assert_matches_style("width": "68.1406px",
                                                      "position": "relative",
                                                      "height": "19px",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(62, 62, 62, 1)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgb(170, 170, 170)",
                                                           "font-size": "12px",
                                                           "display": "block",
                                                           "color": "rgba(170, 170, 170, 1)",
                                                           "margin-top": "10px",)
  end

  test "vertical - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "ads by CodeFund")

    find("div", id: "cf").assert_matches_style("margin-top": "0px",
                                               "margin-left": "629.5px",
                                               "background-color": "rgba(0, 0, 0, 0)",
                                               "width": "125px",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "margin-bottom": "8px",)
    find("img", class: "cf-img").assert_matches_style("width": "68.1406px",
                                                      "position": "relative",
                                                      "height": "19px",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(255, 255, 255, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.6)",
                                                           "font-size": "12px",
                                                           "display": "block",
                                                           "color": "rgba(255, 255, 255, 0.6)",
                                                           "margin-top": "10px",)
  end
end
