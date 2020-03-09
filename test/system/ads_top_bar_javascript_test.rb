require_relative "system_test_helper"

class AdsTopBarJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "top-bar")
  end

  teardown do
    travel_back
  end

  test "top bar - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "Ethical ads by CodeFund")

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "position": "relative",
                                               "z-index": "999999",
                                               "background-color": "rgb(44, 106, 199)",
                                               "box-shadow": "rgba(0, 0, 0, 0.25) 0px 1px 10px 0px")
    find("a", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                        "padding": "14px 20px",
                                                        "text-align": "left",
                                                        "display": "flex",
                                                        "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-smartbar-left").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-img-wrapper").assert_matches_style("line-height": "0px")
    find("img", class: "cf-img").assert_matches_style("margin-right": "20px", "width": "100px", "height": "40px")
    find("span", class: "cf-text").assert_matches_style("font-size": "16px",
                                                        "color": "rgb(255, 255, 255)",
                                                        "margin-right": "20px")
    find("span", class: "cf-smartbar-right").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-cta").assert_matches_style("box-sizing": "border-box",
                                                       "padding": "8px 12px",
                                                       "border-radius": "4px",
                                                       "background-color": "rgb(255, 255, 255)",
                                                       "color": "rgb(44, 106, 199)",
                                                       "text-transform": "uppercase",
                                                       "white-space": "nowrap",
                                                       "letter-spacing": "1px",
                                                       "line-height": "12px",
                                                       "font-weight": "600",
                                                       "font-size": "12px")
    find("div", class: "cf-footer").assert_matches_style("position": "absolute",
                                                         "right": "20px",
                                                         "bottom": "5px",
                                                         "border-top": "0px none rgb(255, 255, 255)",
                                                         "border-top-left-radius": "3px",
                                                         "color": "rgb(255, 255, 255)",
                                                         "text-decoration": "none solid rgb(255, 255, 255)",
                                                         "text-transform": "uppercase",
                                                         "letter-spacing": "1px",
                                                         "line-height": "8px",
                                                         "font-weight": "300",
                                                         "font-size": "8px")
    find("span", class: "cf-close").assert_matches_style("color": "rgb(255, 255, 255)", "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("font-size": "8px",
                                                           "text-decoration": "none solid rgb(255, 255, 255)",
                                                           "color": "rgb(255, 255, 255)")
  end

  test "top-bar - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "Ethical ads by CodeFund")

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "position": "relative",
                                               "z-index": "999999",
                                               "background-color": "rgb(44, 106, 199)",
                                               "box-shadow": "rgba(0, 0, 0, 0.25) 0px 1px 10px 0px")
    find("a", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                        "padding": "14px 20px",
                                                        "text-align": "left",
                                                        "display": "flex",
                                                        "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-smartbar-left").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-img-wrapper").assert_matches_style("line-height": "0px")
    find("img", class: "cf-img").assert_matches_style("margin-right": "20px", "width": "100px", "height": "40px")
    find("span", class: "cf-text").assert_matches_style("font-size": "16px",
                                                        "color": "rgb(255, 255, 255)",
                                                        "margin-right": "20px")
    find("span", class: "cf-smartbar-right").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-cta").assert_matches_style("box-sizing": "border-box",
                                                       "padding": "8px 12px",
                                                       "border-radius": "4px",
                                                       "background-color": "rgb(255, 255, 255)",
                                                       "color": "rgb(44, 106, 199)",
                                                       "text-transform": "uppercase",
                                                       "white-space": "nowrap",
                                                       "letter-spacing": "1px",
                                                       "line-height": "12px",
                                                       "font-weight": "600",
                                                       "font-size": "12px")
    find("div", class: "cf-footer").assert_matches_style("position": "absolute",
                                                         "right": "20px",
                                                         "bottom": "5px",
                                                         "border-top": "0px none rgb(255, 255, 255)",
                                                         "border-top-left-radius": "3px",
                                                         "color": "rgb(255, 255, 255)",
                                                         "text-decoration": "none solid rgb(255, 255, 255)",
                                                         "text-transform": "uppercase",
                                                         "letter-spacing": "1px",
                                                         "line-height": "8px",
                                                         "font-weight": "300",
                                                         "font-size": "8px")
    find("span", class: "cf-close").assert_matches_style("color": "rgb(255, 255, 255)", "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("font-size": "8px",
                                                           "text-decoration": "none solid rgb(255, 255, 255)",
                                                           "color": "rgb(255, 255, 255)")
  end

  test "top-bar - fallback ad with light theme" do
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "Ethical ads by CodeFund")

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "position": "relative",
                                               "z-index": "999999",
                                               "background-color": "rgb(44, 106, 199)",
                                               "box-shadow": "rgba(0, 0, 0, 0.25) 0px 1px 10px 0px")
    find("a", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                        "padding": "14px 20px",
                                                        "text-align": "left",
                                                        "display": "flex",
                                                        "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-smartbar-left").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-img-wrapper").assert_matches_style("line-height": "0px")
    find("img", class: "cf-img").assert_matches_style("margin-right": "20px", "width": "100px", "height": "40px")
    find("span", class: "cf-text").assert_matches_style("font-size": "16px",
                                                        "color": "rgb(255, 255, 255)",
                                                        "margin-right": "20px")
    find("span", class: "cf-smartbar-right").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-cta").assert_matches_style("box-sizing": "border-box",
                                                       "padding": "8px 12px",
                                                       "border-radius": "4px",
                                                       "background-color": "rgb(255, 255, 255)",
                                                       "color": "rgb(44, 106, 199)",
                                                       "text-transform": "uppercase",
                                                       "white-space": "nowrap",
                                                       "letter-spacing": "1px",
                                                       "line-height": "12px",
                                                       "font-weight": "600",
                                                       "font-size": "12px")
    find("div", class: "cf-footer").assert_matches_style("position": "absolute",
                                                         "right": "20px",
                                                         "bottom": "5px",
                                                         "border-top": "0px none rgb(255, 255, 255)",
                                                         "border-top-left-radius": "3px",
                                                         "color": "rgb(255, 255, 255)",
                                                         "text-decoration": "none solid rgb(255, 255, 255)",
                                                         "text-transform": "uppercase",
                                                         "letter-spacing": "1px",
                                                         "line-height": "8px",
                                                         "font-weight": "300",
                                                         "font-size": "8px")
    find("span", class: "cf-close").assert_matches_style("color": "rgb(255, 255, 255)", "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("font-size": "8px",
                                                           "text-decoration": "none solid rgb(255, 255, 255)",
                                                           "color": "rgb(255, 255, 255)")
  end

  test "top-bar - fallback ad with dark theme" do
    @property.update ad_theme: "dark"
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link(text: "Ethical ads by CodeFund")

    find("div", id: "cf").assert_matches_style('font-family': "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "position": "relative",
                                               "z-index": "999999",
                                               "background-color": "rgb(44, 106, 199)",
                                               "box-shadow": "rgba(0, 0, 0, 0.25) 0px 1px 10px 0px")
    find("a", class: "cf-wrapper").assert_matches_style("box-sizing": "border-box",
                                                        "padding": "14px 20px",
                                                        "text-align": "left",
                                                        "display": "flex",
                                                        "text-decoration": "none solid rgb(0, 0, 238)")
    find("span", class: "cf-smartbar-left").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-img-wrapper").assert_matches_style("line-height": "0px")
    find("img", class: "cf-img").assert_matches_style("margin-right": "20px", "width": "100px", "height": "40px")
    find("span", class: "cf-text").assert_matches_style("font-size": "16px",
                                                        "color": "rgb(255, 255, 255)",
                                                        "margin-right": "20px")
    find("span", class: "cf-smartbar-right").assert_matches_style("display": "flex", "align-items": "center")
    find("span", class: "cf-cta").assert_matches_style("box-sizing": "border-box",
                                                       "padding": "8px 12px",
                                                       "border-radius": "4px",
                                                       "background-color": "rgb(255, 255, 255)",
                                                       "color": "rgb(44, 106, 199)",
                                                       "text-transform": "uppercase",
                                                       "white-space": "nowrap",
                                                       "letter-spacing": "1px",
                                                       "line-height": "12px",
                                                       "font-weight": "600",
                                                       "font-size": "12px")
    find("div", class: "cf-footer").assert_matches_style("position": "absolute",
                                                         "right": "20px",
                                                         "bottom": "5px",
                                                         "border-top": "0px none rgb(255, 255, 255)",
                                                         "border-top-left-radius": "3px",
                                                         "color": "rgb(255, 255, 255)",
                                                         "text-decoration": "none solid rgb(255, 255, 255)",
                                                         "text-transform": "uppercase",
                                                         "letter-spacing": "1px",
                                                         "line-height": "8px",
                                                         "font-weight": "300",
                                                         "font-size": "8px")
    find("span", class: "cf-close").assert_matches_style("color": "rgb(255, 255, 255)", "cursor": "pointer")
    find("a", class: "cf-powered-by").assert_matches_style("font-size": "8px",
                                                           "text-decoration": "none solid rgb(255, 255, 255)",
                                                           "color": "rgb(255, 255, 255)")
  end
end
