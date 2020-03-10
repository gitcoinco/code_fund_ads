require_relative "system_test_helper"

class AdsImageOnlyJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "image-only")
  end

  teardown do
    travel_back
  end

  test "image only - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "supported by ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "280px", "margin": "0px 552px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "padding": "15px",
                                                           "overflow": "visible",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif")
    find("a", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                            "margin-bottom": "8px",
                                                            "box-shadow": "none")
    find("img", class: "cf-img").assert_matches_style("width": "150px",
                                                      "height": "150px",
                                                      "position": "relative",
                                                      "margin-top": "0px",
                                                      "margin-right": "0px",
                                                      "margin-left": "0px",
                                                      "margin-bottom": "0px")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgb(102, 119, 136)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "text-align": "center",
                                                           "color": "rgb(102, 119, 136)",
                                                           "background-color": "rgba(0, 0, 0, 0)",
                                                           "line-height": "15.4px")
  end

  test "image only - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_powered_by_link(text: "supported by ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "280px", "margin": "0px 552px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "padding": "15px",
                                                           "overflow": "visible",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif")
    find("a", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                            "margin-bottom": "8px",
                                                            "box-shadow": "none")
    find("img", class: "cf-img").assert_matches_style("width": "150px",
                                                      "height": "150px",
                                                      "position": "relative",
                                                      "margin-top": "0px",
                                                      "margin-right": "0px",
                                                      "margin-left": "0px",
                                                      "margin-bottom": "0px")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.6)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "text-align": "center",
                                                           "color": "rgba(255, 255, 255, 0.6)",
                                                           "background-color": "rgba(0, 0, 0, 0)",
                                                           "line-height": "15.4px")
  end

  test "image only - fallback ad with light theme" do
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "supported by ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "280px", "margin": "0px 552px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "padding": "15px",
                                                           "overflow": "visible",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif")
    find("a", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                            "margin-bottom": "8px",
                                                            "box-shadow": "none")
    find("img", class: "cf-img").assert_matches_style("width": "150px",
                                                      "height": "150px",
                                                      "position": "relative",
                                                      "margin-top": "0px",
                                                      "margin-right": "0px",
                                                      "margin-left": "0px",
                                                      "margin-bottom": "0px")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgb(102, 119, 136)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "text-align": "center",
                                                           "color": "rgb(102, 119, 136)",
                                                           "background-color": "rgba(0, 0, 0, 0)",
                                                           "line-height": "15.4px")
  end

  test "image only - fallback ad with dark theme" do
    @property.update ad_theme: "dark"
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_powered_by_link(text: "supported by ethical ad by CodeFund")

    find("div", id: "cf").assert_matches_style("max-width": "280px", "margin": "0px 552px")
    find("span", class: "cf-wrapper").assert_matches_style("display": "block",
                                                           "padding": "15px",
                                                           "overflow": "visible",
                                                           "font-size": "14px",
                                                           "line-height": "19.6px",
                                                           "font-family": "Helvetica, Arial, sans-serif")
    find("a", class: "cf-img-wrapper").assert_matches_style("display": "block",
                                                            "margin-bottom": "8px",
                                                            "box-shadow": "none")
    find("img", class: "cf-img").assert_matches_style("width": "150px",
                                                      "height": "150px",
                                                      "position": "relative",
                                                      "margin-top": "0px",
                                                      "margin-right": "0px",
                                                      "margin-left": "0px",
                                                      "margin-bottom": "0px")
    find("a", class: "cf-powered-by").assert_matches_style("box-shadow": "none",
                                                           "padding": "0px",
                                                           "text-decoration": "none solid rgba(255, 255, 255, 0.6)",
                                                           "margin-top": "5px",
                                                           "font-size": "11px",
                                                           "display": "block",
                                                           "font-weight": "400",
                                                           "text-align": "center",
                                                           "color": "rgba(255, 255, 255, 0.6)",
                                                           "background-color": "rgba(0, 0, 0, 0)",
                                                           "line-height": "15.4px")
  end
end
