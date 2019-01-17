require "application_system_test_case"

class ProspectiveJobPostingsTest < ApplicationSystemTestCase
  setup do
    @prospective_job_posting = prospective_job_postings(:one)
  end

  test "visiting the index" do
    visit prospective_job_postings_url
    assert_selector "h1", text: "Prospective Job Postings"
  end

  test "creating a Prospective job posting" do
    visit prospective_job_postings_url
    click_on "New Prospective Job Posting"

    click_on "Create Prospective job posting"

    assert_text "Prospective job posting was successfully created"
    click_on "Back"
  end

  test "updating a Prospective job posting" do
    visit prospective_job_postings_url
    click_on "Edit", match: :first

    click_on "Update Prospective job posting"

    assert_text "Prospective job posting was successfully updated"
    click_on "Back"
  end

  test "destroying a Prospective job posting" do
    visit prospective_job_postings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Prospective job posting was successfully destroyed"
  end
end
