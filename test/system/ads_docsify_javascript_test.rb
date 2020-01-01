require_relative "system_test_helper"

class AdsDocsifyJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "docsify")
    Creative.any_instance.stubs(small_image: OpenStruct.new(cloudfront_url: "https://www.test.codefund.io/test.png"))
  end

  teardown do
    travel_back
  end

  test "docsify - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a premium campaign ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin": "0px 527px")
    find("div", class: "cf-wrapper").assert_matches_style("display": "block",
                                                          "overflow": "hidden",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "padding": "15px",)
    find("div", class: "clearfix").assert_matches_style("overflow": "auto")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("vertical-align": "middle",
                                                      "max-width": "65px",
                                                      "position": "relative",
                                                      "border": "0px none rgb(0, 0, 238)")
    find("span", class: "cf-text").assert_matches_style("color": "rgba(51, 51, 51, 1)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                           "margin-top": "8px",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "letter-spacing": "0.5px",
                                                           "text-align": "center",
                                                           "color": "rgba(0, 0, 0, 0.8)",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",)
  end

  test "docsify - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @premium_campaign
    assert_creative_body @premium_campaign
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a premium campaign ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin": "0px 527px")
    find("div", class: "cf-wrapper").assert_matches_style("display": "block",
                                                          "overflow": "hidden",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "padding": "15px",)
    find("div", class: "clearfix").assert_matches_style("overflow": "auto")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("vertical-align": "middle",
                                                      "max-width": "65px",
                                                      "position": "relative",
                                                      "border": "0px none rgb(0, 0, 238)")
    find("span", class: "cf-text").assert_matches_style("color": "rgba(255, 255, 255, 0.7)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.7)",
                                                           "margin-top": "8px",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "letter-spacing": "0.5px",
                                                           "text-align": "center",
                                                           "color": "rgba(255, 255, 255, 0.7)",
                                                           "background-color": "rgba(255, 255, 255, 0.05)",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",)
  end

  test "docsify - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a fallback campaign ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin": "0px 527px")
    find("div", class: "cf-wrapper").assert_matches_style("display": "block",
                                                          "overflow": "hidden",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "padding": "15px",)
    find("div", class: "clearfix").assert_matches_style("overflow": "auto")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("vertical-align": "middle",
                                                      "max-width": "65px",
                                                      "position": "relative",
                                                      "border": "0px none rgb(0, 0, 238)")
    find("span", class: "cf-text").assert_matches_style("color": "rgba(51, 51, 51, 1)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                           "margin-top": "8px",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "letter-spacing": "0.5px",
                                                           "text-align": "center",
                                                           "color": "rgba(0, 0, 0, 0.8)",
                                                           "background-color": "rgba(0, 0, 0, 0.05)",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",)
  end

  test "docsify - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_headline @fallback_campaign
    assert_creative_body @fallback_campaign
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "This is a fallback campaign ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin": "0px 527px")
    find("div", class: "cf-wrapper").assert_matches_style("display": "block",
                                                          "overflow": "hidden",
                                                          "font-size": "14px",
                                                          "line-height": "19.6px",
                                                          "font-family": "Helvetica, Arial, sans-serif",
                                                          "padding": "15px",)
    find("div", class: "clearfix").assert_matches_style("overflow": "auto")
    find("a", class: "cf-sponsored-by").assert_matches_style("box-shadow": "none", "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-img-wrapper").assert_matches_style("float": "left", "margin-right": "15px")
    find("img", class: "cf-img").assert_matches_style("vertical-align": "middle",
                                                      "max-width": "65px",
                                                      "position": "relative",
                                                      "border": "0px none rgb(0, 0, 238)")
    find("span", class: "cf-text").assert_matches_style("color": "rgba(255, 255, 255, 0.7)")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.7)",
                                                           "margin-top": "8px",
                                                           "font-size": "9px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "letter-spacing": "0.5px",
                                                           "text-align": "center",
                                                           "color": "rgba(255, 255, 255, 0.7)",
                                                           "background-color": "rgba(255, 255, 255, 0.05)",
                                                           "line-height": "19.8px",
                                                           "text-transform": "uppercase",)
  end
end
