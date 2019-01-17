require 'test_helper'

class ProspectiveJobPostingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prospective_job_posting = prospective_job_postings(:one)
  end

  test "should get index" do
    get prospective_job_postings_url
    assert_response :success
  end

  test "should get new" do
    get new_prospective_job_posting_url
    assert_response :success
  end

  test "should create prospective_job_posting" do
    assert_difference('ProspectiveJobPosting.count') do
      post prospective_job_postings_url, params: { prospective_job_posting: {  } }
    end

    assert_redirected_to prospective_job_posting_url(ProspectiveJobPosting.last)
  end

  test "should show prospective_job_posting" do
    get prospective_job_posting_url(@prospective_job_posting)
    assert_response :success
  end

  test "should get edit" do
    get edit_prospective_job_posting_url(@prospective_job_posting)
    assert_response :success
  end

  test "should update prospective_job_posting" do
    patch prospective_job_posting_url(@prospective_job_posting), params: { prospective_job_posting: {  } }
    assert_redirected_to prospective_job_posting_url(@prospective_job_posting)
  end

  test "should destroy prospective_job_posting" do
    assert_difference('ProspectiveJobPosting.count', -1) do
      delete prospective_job_posting_url(@prospective_job_posting)
    end

    assert_redirected_to prospective_job_postings_url
  end
end
