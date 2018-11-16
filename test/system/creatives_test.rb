require "application_system_test_case"

class CreativesTest < ApplicationSystemTestCase
  setup do
    @creative = creatives(:one)
  end

  test "visiting the index" do
    visit creatives_url
    assert_selector "h1", text: "Creatives"
  end

  test "creating a Creative" do
    visit creatives_url
    click_on "New Creative"

    click_on "Create Creative"

    assert_text "Creative was successfully created"
    click_on "Back"
  end

  test "updating a Creative" do
    visit creatives_url
    click_on "Edit", match: :first

    click_on "Update Creative"

    assert_text "Creative was successfully updated"
    click_on "Back"
  end

  test "destroying a Creative" do
    visit creatives_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Creative was successfully destroyed"
  end
end
