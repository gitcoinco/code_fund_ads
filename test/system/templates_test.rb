require "application_system_test_case"

class TemplatesTest < ApplicationSystemTestCase
  setup do
    @template = templates(:one)
  end

  test "visiting the index" do
    visit templates_url
    assert_selector "h1", text: "Templates"
  end

  test "creating a Template" do
    visit templates_url
    click_on "New Template"

    click_on "Create Template"

    assert_text "Template was successfully created"
    click_on "Back"
  end

  test "updating a Template" do
    visit templates_url
    click_on "Edit", match: :first

    click_on "Update Template"

    assert_text "Template was successfully updated"
    click_on "Back"
  end

  test "destroying a Template" do
    visit templates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Template was successfully destroyed"
  end
end
