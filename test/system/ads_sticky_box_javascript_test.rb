require_relative "system_test_helper"

class AdsStickyBoxJavascriptTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    ad_template_setup(ad_template: "sticky-box")
  end

  teardown do
    travel_back
  end

  test "sticky-box - premium ad with light theme" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @premium_campaign
    assert_impression_pixel @property

    find("div", id: "cf").assert_matches_style("background-color": "rgba(255, 255, 255, 0.98)",
                                               "border-radius": "3px",
                                               "border": "1px solid rgb(204, 204, 204)",
                                               "box-shadow": "rgba(0, 0, 0, 0.15) 2px 2px 12px 0px",
                                               "display": "flex",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "padding": "10px",
                                               "position": "fixed",
                                               "width": "360px",
                                               "z-index": "999",
                                               "animation": "0.85s ease 0s 1 normal none running fadein")
    find("a", class: "cf-powered-by").assert_matches_style("background-color": "rgb(204, 204, 204)",
                                                           "border-radius": "2px 0px 0px 2px",
                                                           "bottom": "57px",
                                                           "color": "rgb(51, 51, 51)",
                                                           "display": "block",
                                                           "font-size": "11px",
                                                           "font-weight": "400",
                                                           "left": "-19px",
                                                           "padding": "2px 0px",
                                                           "position": "absolute",
                                                           "text-align": "center",
                                                           "text-decoration": "none solid rgb(51, 51, 51)",
                                                           "width": "18px")
    find("a", class: "cf-sponsored-by").assert_matches_style("width": "360px")
    find("img", class: "cf-img").assert_matches_style("float": "left",
                                                      "margin": "0px 10px 0px 0px",
                                                      "width": "55px",
                                                      "height": "55px")
    find("strong", class: "cf-headline").assert_matches_style("display": "block",
                                                              "font-size": "14px",
                                                              "font-weight": "600",
                                                              "line-height": "21px")
    find("span", class: "cf-body").assert_matches_style("display": "block",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "color": "rgb(65, 65, 65)",
                                                        "max-width": "350px")
    find("span", class: "cf-body").assert_matches_style("color": "rgb(65, 65, 65)",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "text-decoration": "none solid rgb(65, 65, 65)")
    find('span[data-behavior="close"]').click
    refute_selector("div#cf")
  end

  test "sticky-box - premium ad with dark theme" do
    @property.update ad_theme: "dark"
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @premium_campaign
    assert_impression_pixel @property

    find("div", id: "cf").assert_matches_style("background-color": "rgba(255, 255, 255, 0.98)",
                                               "border-radius": "3px",
                                               "border": "1px solid rgb(204, 204, 204)",
                                               "box-shadow": "rgba(0, 0, 0, 0.15) 2px 2px 12px 0px",
                                               "display": "flex",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "padding": "10px",
                                               "position": "fixed",
                                               "width": "360px",
                                               "z-index": "999",
                                               "animation": "0.85s ease 0s 1 normal none running fadein")
    find("a", class: "cf-powered-by").assert_matches_style("background-color": "rgb(204, 204, 204)",
                                                           "border-radius": "2px 0px 0px 2px",
                                                           "bottom": "57px",
                                                           "color": "rgb(51, 51, 51)",
                                                           "display": "block",
                                                           "font-size": "11px",
                                                           "font-weight": "400",
                                                           "left": "-19px",
                                                           "padding": "2px 0px",
                                                           "position": "absolute",
                                                           "text-align": "center",
                                                           "text-decoration": "none solid rgb(51, 51, 51)",
                                                           "width": "18px")
    find("a", class: "cf-sponsored-by").assert_matches_style("width": "360px")
    find("img", class: "cf-img").assert_matches_style("float": "left",
                                                      "margin": "0px 10px 0px 0px",
                                                      "width": "55px",
                                                      "height": "55px")
    find("strong", class: "cf-headline").assert_matches_style("display": "block",
                                                              "font-size": "14px",
                                                              "font-weight": "600",
                                                              "line-height": "21px")
    find("span", class: "cf-body").assert_matches_style("display": "block",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "color": "rgb(65, 65, 65)",
                                                        "max-width": "350px")
    find("span", class: "cf-body").assert_matches_style("color": "rgb(65, 65, 65)",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "text-decoration": "none solid rgb(65, 65, 65)")
    find('span[data-behavior="close"]').click
    refute_selector("div#cf")
  end

  test "sticky-box - fallback ad with light theme" do
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @fallback_campaign
    assert_impression_pixel @property

    find("div", id: "cf").assert_matches_style("background-color": "rgba(255, 255, 255, 0.98)",
                                               "border-radius": "3px",
                                               "border": "1px solid rgb(204, 204, 204)",
                                               "box-shadow": "rgba(0, 0, 0, 0.15) 2px 2px 12px 0px",
                                               "display": "flex",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "padding": "10px",
                                               "position": "fixed",
                                               "width": "360px",
                                               "z-index": "999",
                                               "animation": "0.85s ease 0s 1 normal none running fadein")
    find("a", class: "cf-powered-by").assert_matches_style("background-color": "rgb(204, 204, 204)",
                                                           "border-radius": "2px 0px 0px 2px",
                                                           "bottom": "57px",
                                                           "color": "rgb(51, 51, 51)",
                                                           "display": "block",
                                                           "font-size": "11px",
                                                           "font-weight": "400",
                                                           "left": "-19px",
                                                           "padding": "2px 0px",
                                                           "position": "absolute",
                                                           "text-align": "center",
                                                           "text-decoration": "none solid rgb(51, 51, 51)",
                                                           "width": "18px")
    find("a", class: "cf-sponsored-by").assert_matches_style("width": "360px")
    find("img", class: "cf-img").assert_matches_style("float": "left",
                                                      "margin": "0px 10px 0px 0px",
                                                      "width": "55px",
                                                      "height": "55px")
    find("strong", class: "cf-headline").assert_matches_style("display": "block",
                                                              "font-size": "14px",
                                                              "font-weight": "600",
                                                              "line-height": "21px")
    find("span", class: "cf-body").assert_matches_style("display": "block",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "color": "rgb(65, 65, 65)",
                                                        "max-width": "350px")
    find("span", class: "cf-body").assert_matches_style("color": "rgb(65, 65, 65)",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "text-decoration": "none solid rgb(65, 65, 65)")
    find('span[data-behavior="close"]').click
    refute_selector("div#cf")
  end

  test "sticky-box - fallback ad with dark theme" do
    @property.update ad_theme: "dark"
    @premium_campaign.update audience_ids: [], keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_creative_body @fallback_campaign
    assert_impression_pixel @property

    find("div", id: "cf").assert_matches_style("background-color": "rgba(255, 255, 255, 0.98)",
                                               "border-radius": "3px",
                                               "border": "1px solid rgb(204, 204, 204)",
                                               "box-shadow": "rgba(0, 0, 0, 0.15) 2px 2px 12px 0px",
                                               "display": "flex",
                                               "font-family": "\"Helvetica Neue\", Helvetica, Arial, sans-serif",
                                               "padding": "10px",
                                               "position": "fixed",
                                               "width": "360px",
                                               "z-index": "999",
                                               "animation": "0.85s ease 0s 1 normal none running fadein")
    find("a", class: "cf-powered-by").assert_matches_style("background-color": "rgb(204, 204, 204)",
                                                           "border-radius": "2px 0px 0px 2px",
                                                           "bottom": "57px",
                                                           "color": "rgb(51, 51, 51)",
                                                           "display": "block",
                                                           "font-size": "11px",
                                                           "font-weight": "400",
                                                           "left": "-19px",
                                                           "padding": "2px 0px",
                                                           "position": "absolute",
                                                           "text-align": "center",
                                                           "text-decoration": "none solid rgb(51, 51, 51)",
                                                           "width": "18px")
    find("a", class: "cf-sponsored-by").assert_matches_style("width": "360px")
    find("img", class: "cf-img").assert_matches_style("float": "left",
                                                      "margin": "0px 10px 0px 0px",
                                                      "width": "55px",
                                                      "height": "55px")
    find("strong", class: "cf-headline").assert_matches_style("display": "block",
                                                              "font-size": "14px",
                                                              "font-weight": "600",
                                                              "line-height": "21px")
    find("span", class: "cf-body").assert_matches_style("display": "block",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "color": "rgb(65, 65, 65)",
                                                        "max-width": "350px")
    find("span", class: "cf-body").assert_matches_style("color": "rgb(65, 65, 65)",
                                                        "font-size": "13px",
                                                        "line-height": "17.55px",
                                                        "text-decoration": "none solid rgb(65, 65, 65)")
    find('span[data-behavior="close"]').click
    refute_selector("div#cf")
  end
end
