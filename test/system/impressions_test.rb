require "application_system_test_case"

class ImpressionsTest < ApplicationSystemTestCase
  setup do
    @impression = impressions(:one)
  end

  test "visiting the index" do
    visit impressions_url
    assert_selector "h1", text: "Impressions"
  end

  test "creating a Impression" do
    visit impressions_url
    click_on "New Impression"

    click_on "Create Impression"

    assert_text "Impression was successfully created"
    click_on "Back"
  end

  test "updating a Impression" do
    visit impressions_url
    click_on "Edit", match: :first

    click_on "Update Impression"

    assert_text "Impression was successfully updated"
    click_on "Back"
  end

  test "destroying a Impression" do
    visit impressions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Impression was successfully destroyed"
  end
end
