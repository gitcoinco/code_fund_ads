require "application_system_test_case"

class DistributionsTest < ApplicationSystemTestCase
  setup do
    @distribution = distributions(:one)
  end

  test "visiting the index" do
    visit distributions_url
    assert_selector "h1", text: "Distributions"
  end

  test "creating a Distribution" do
    visit distributions_url
    click_on "New Distribution"

    click_on "Create Distribution"

    assert_text "Distribution was successfully created"
    click_on "Back"
  end

  test "updating a Distribution" do
    visit distributions_url
    click_on "Edit", match: :first

    click_on "Update Distribution"

    assert_text "Distribution was successfully updated"
    click_on "Back"
  end

  test "destroying a Distribution" do
    visit distributions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Distribution was successfully destroyed"
  end
end
