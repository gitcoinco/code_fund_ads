require_relative "system_test_helper"

class AdsMediaJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "media")
    Creative.any_instance.stubs(small_image: OpenStruct.new(cloudfront_url: "https://www.test.codefund.io/test.png"))
  end

  teardown do
    travel_back
  end

  test "media - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin-top": "0px", "margin-left": "527px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "AkzidenzGrotesk-Regular, \"Helvetica Neue\", Helvetica",
                                                           "text-align": "left",
                                                           "line-height": "16.8px",)
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative",)
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                      "font-weight": "350",
                                                      "font-size": "12px",
                                                      "color": "rgba(0, 0, 0, 0.8)",)
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgb(170, 170, 170)",
                                                           "margin-top": "5px",
                                                           "font-size": "10px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(170, 170, 170, 1)",)
  end

  test "media - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin-top": "0px", "margin-left": "527px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "AkzidenzGrotesk-Regular, \"Helvetica Neue\", Helvetica",
                                                           "text-align": "left",
                                                           "line-height": "16.8px",)
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative",)
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(255, 255, 255, 0.8)",
                                                      "font-weight": "350",
                                                      "font-size": "12px",
                                                      "color": "rgba(255, 255, 255, 0.8)",)
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgb(170, 170, 170)",
                                                           "margin-top": "5px",
                                                           "font-size": "10px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(170, 170, 170, 1)",)
  end

  test "media - fallback ad with light theme" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin-top": "0px", "margin-left": "527px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "AkzidenzGrotesk-Regular, \"Helvetica Neue\", Helvetica",
                                                           "text-align": "left",
                                                           "line-height": "16.8px",)
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative",)
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                      "font-weight": "350",
                                                      "font-size": "12px",
                                                      "color": "rgba(0, 0, 0, 0.8)",)
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgb(170, 170, 170)",
                                                           "margin-top": "5px",
                                                           "font-size": "10px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(170, 170, 170, 1)",)
  end

  test "media - fallback ad with dark theme" do
    @property.update keywords: [], ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_powered_by_link

    find("div", id: "cf").assert_matches_style("max-width": "330px", "margin-top": "0px", "margin-left": "527px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "AkzidenzGrotesk-Regular, \"Helvetica Neue\", Helvetica",
                                                           "text-align": "left",
                                                           "line-height": "16.8px",)
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative",)
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(255, 255, 255, 0.8)",
                                                      "font-weight": "350",
                                                      "font-size": "12px",
                                                      "color": "rgba(255, 255, 255, 0.8)",)
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgb(170, 170, 170)",
                                                           "margin-top": "5px",
                                                           "font-size": "10px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(170, 170, 170, 1)",)
  end
end
