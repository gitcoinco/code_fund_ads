require_relative "system_test_helper"

class AdsSquareJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "square")
    Creative.any_instance.stubs(large_image: OpenStruct.new(cloudfront_url: "https://www.test.codefund.io/test.png"))
  end

  teardown do
    travel_back
  end

  test "square - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "255px",
                                               "margin-top": "0px",
                                               "margin-left": "564.5px",
                                               "background-color": "rgba(250, 250, 250, 1)",
                                               "box-shadow": "rgba(0, 0, 0, 0.1) 0px 0px 0px 1px",
                                               "display": "block",
                                               "line-height": "24px",
                                               "overflow": "hidden",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "line-height": "14px",
                                                               "margin-bottom": "8px",
                                                               "border-bottom-width": "1px",
                                                               "border-bottom-color": "rgba(250, 250, 250, 1)",
                                                               "border-bottom-style": "solid",)
    find("img", class: "cf-img").assert_matches_style("width": "72.0156px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(0, 0, 0, 0.8)",
                                                        "padding-top": "0px",
                                                        "padding-left": "14px",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "color": "rgba(0, 0, 0, 0.8)",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "font-weight": "400",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",
                                                           "letter-spacing": "0.5px")
  end

  test "square - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "255px",
                                               "margin-top": "0px",
                                               "margin-left": "564.5px",
                                               "background-color": "rgba(250, 250, 250, 1)",
                                               "box-shadow": "rgba(0, 0, 0, 0.1) 0px 0px 0px 1px",
                                               "display": "block",
                                               "line-height": "24px",
                                               "overflow": "hidden",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "line-height": "14px",
                                                               "margin-bottom": "8px",
                                                               "border-bottom-width": "1px",
                                                               "border-bottom-color": "rgba(250, 250, 250, 1)",
                                                               "border-bottom-style": "solid",)
    find("img", class: "cf-img").assert_matches_style("width": "72.0156px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(0, 0, 0, 0.8)",
                                                        "padding-top": "0px",
                                                        "padding-left": "14px",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "color": "rgba(0, 0, 0, 0.8)",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "font-weight": "400",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",
                                                           "letter-spacing": "0.5px")
  end

  test "square - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "255px",
                                               "margin-top": "0px",
                                               "margin-left": "564.5px",
                                               "background-color": "rgba(250, 250, 250, 1)",
                                               "box-shadow": "rgba(0, 0, 0, 0.1) 0px 0px 0px 1px",
                                               "display": "block",
                                               "line-height": "24px",
                                               "overflow": "hidden",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "line-height": "14px",
                                                               "margin-bottom": "8px",
                                                               "border-bottom-width": "1px",
                                                               "border-bottom-color": "rgba(250, 250, 250, 1)",
                                                               "border-bottom-style": "solid",)
    find("img", class: "cf-img").assert_matches_style("width": "68.1406px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(0, 0, 0, 0.8)",
                                                        "padding-top": "0px",
                                                        "padding-left": "14px",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "color": "rgba(0, 0, 0, 0.8)",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "font-weight": "400",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",
                                                           "letter-spacing": "0.5px")
  end

  test "square - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "255px",
                                               "margin-top": "0px",
                                               "margin-left": "564.5px",
                                               "background-color": "rgba(250, 250, 250, 1)",
                                               "box-shadow": "rgba(0, 0, 0, 0.1) 0px 0px 0px 1px",
                                               "display": "block",
                                               "line-height": "24px",
                                               "overflow": "hidden",)
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif",
                                                           "font-weight": "350",
                                                           "margin-left": "0px",
                                                           "margin-right": "0px")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                               "line-height": "14px",
                                                               "margin-bottom": "8px",
                                                               "border-bottom-width": "1px",
                                                               "border-bottom-color": "rgba(250, 250, 250, 1)",
                                                               "border-bottom-style": "solid",)
    find("img", class: "cf-img").assert_matches_style("width": "68.1406px",
                                                      "position": "relative",
                                                      "vertical-align": "middle",)
    find("span", class: "cf-text").assert_matches_style("color": "rgba(0, 0, 0, 0.8)",
                                                        "padding-top": "0px",
                                                        "padding-left": "14px",)
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "color": "rgba(0, 0, 0, 0.8)",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "font-weight": "400",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",
                                                           "letter-spacing": "0.5px")
  end
end
