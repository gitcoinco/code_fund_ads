require_relative "system_test_helper"

class AdsRectangleNarrowJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "rectangle-narrow")
    Creative.any_instance.stubs(small_image: OpenStruct.new(cloudfront_url: "https://www.test.codefund.io/test.png"))
  end

  teardown do
    travel_back
  end

  test "rectangle narrow - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "ads served ethically")

    find("div", id: "cf").assert_matches_style("max-width": "330px",
                                               "margin-top": "0px",
                                               "margin-left": "527px",
                                               "background-color": "rgba(0, 0, 0, 0.05)")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "overflow": "hidden",
                                                           "font-size": "12px",
                                                           "line-height": "16.8px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "padding-top": "14px",
                                                           "padding-left": "10px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("max-width": "130px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(0, 0, 0, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgb(119, 119, 119)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "color": "rgba(119, 119, 119, 1)",)
  end

  test "rectangle narrow - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "ads served ethically")

    find("div", id: "cf").assert_matches_style("max-width": "330px",
                                               "margin-top": "0px",
                                               "margin-left": "527px",
                                               "background-color": "rgba(0, 0, 0, 0.05)")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "overflow": "hidden",
                                                           "font-size": "12px",
                                                           "line-height": "16.8px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "padding-top": "14px",
                                                           "padding-left": "10px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("max-width": "130px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(255, 255, 255, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgb(119, 119, 119)",
                                                           "margin-top": "5px",
                                                           "font-size": "12px",
                                                           "display": "block",
                                                           "color": "rgba(119, 119, 119, 1)",)
  end

  test "rectangle narrow - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "ads served ethically")

    find("div", id: "cf").assert_matches_style("max-width": "330px",
                                               "margin-top": "0px",
                                               "margin-left": "527px",
                                               "background-color": "rgba(0, 0, 0, 0.05)")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "overflow": "hidden",
                                                           "font-size": "12px",
                                                           "line-height": "16.8px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "padding-top": "14px",
                                                           "padding-left": "10px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("max-width": "130px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(0, 0, 0, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgb(119, 119, 119)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "color": "rgba(119, 119, 119, 1)",)
  end

  test "rectangle narrow - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "ads served ethically")

    find("div", id: "cf").assert_matches_style("max-width": "330px",
                                               "margin-top": "0px",
                                               "margin-left": "527px",
                                               "background-color": "rgba(0, 0, 0, 0.05)")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "overflow": "hidden",
                                                           "font-size": "12px",
                                                           "line-height": "16.8px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "padding-top": "14px",
                                                           "padding-left": "10px",)
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("max-width": "130px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(255, 255, 255, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgb(119, 119, 119)",
                                                           "margin-top": "5px",
                                                           "font-size": "12px",
                                                           "display": "block",
                                                           "color": "rgba(119, 119, 119, 1)",)
  end
end
