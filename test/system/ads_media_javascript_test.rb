require_relative "system_test_helper"

class AdsMediaJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "media")
  end

  teardown do
    travel_back
  end

  test "media - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "This is a premium campaign Premium ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "none", "margin-top": "0px", "margin-left": "0px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "text-align": "left",
                                                           "line-height": "17px")
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative")
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                     "font-weight": "350",
                                                     "font-size": "14px",
                                                     "color": "rgba(0, 0, 0, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(0, 0, 0, 0.5)")
  end

  test "media - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "This is a premium campaign Premium ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "none", "margin-top": "0px", "margin-left": "0px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "text-align": "left",
                                                           "line-height": "17px")
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative")
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(255, 255, 255, 0.8)",
                                                     "font-weight": "350",
                                                     "font-size": "14px",
                                                     "color": "rgba(255, 255, 255, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgba(255, 255, 255, 0.5)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(255, 255, 255, 0.5)")
  end

  test "media - fallback ad with light theme" do
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "This is a fallback campaign Fallback ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "none", "margin-top": "0px", "margin-left": "0px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "text-align": "left",
                                                           "line-height": "17px")
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative")
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(0, 0, 0, 0.8)",
                                                     "font-weight": "350",
                                                     "font-size": "14px",
                                                     "color": "rgba(0, 0, 0, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgba(0, 0, 0, 0.5)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(0, 0, 0, 0.5)")
  end

  test "media - fallback ad with dark theme" do
    @property.update ad_theme: "dark"
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "This is a fallback campaign Fallback ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "none", "margin-top": "0px", "margin-left": "0px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "flex",
                                                           "font-size": "14px",
                                                           "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                                           "text-align": "left",
                                                           "line-height": "17px")
    find("a", class: "cf-img-wrapper").assert_matches_style("text-decoration": "none solid rgb(0, 0, 238)", "flex-basis": "60px")
    find("img", class: "cf-img").assert_matches_style("border-bottom-left-radius": "5px",
                                                      "border-bottom-right-radius": "5px",
                                                      "border-top-right-radius": "5px",
                                                      "border-top-left-radius": "5px",
                                                      "position": "relative")
    assert_selector("div.cf-media-body")
    find("a", class: "cf-text").assert_matches_style("text-decoration": "none solid rgba(255, 255, 255, 0.8)",
                                                     "font-weight": "350",
                                                     "font-size": "14px",
                                                     "color": "rgba(255, 255, 255, 0.8)")
    find("a", class: "cf-powered-by").assert_matches_style("text-decoration": "none solid rgba(255, 255, 255, 0.5)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "350",
                                                           "color": "rgba(255, 255, 255, 0.5)")
  end
end
