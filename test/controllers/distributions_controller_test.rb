require 'test_helper'

class DistributionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @distribution = distributions(:one)
  end

  test "should get index" do
    get distributions_url
    assert_response :success
  end

  test "should get new" do
    get new_distribution_url
    assert_response :success
  end

  test "should create distribution" do
    assert_difference('Distribution.count') do
      post distributions_url, params: { distribution: {  } }
    end

    assert_redirected_to distribution_url(Distribution.last)
  end

  test "should show distribution" do
    get distribution_url(@distribution)
    assert_response :success
  end

  test "should get edit" do
    get edit_distribution_url(@distribution)
    assert_response :success
  end

  test "should update distribution" do
    patch distribution_url(@distribution), params: { distribution: {  } }
    assert_redirected_to distribution_url(@distribution)
  end

  test "should destroy distribution" do
    assert_difference('Distribution.count', -1) do
      delete distribution_url(@distribution)
    end

    assert_redirected_to distributions_url
  end
end
