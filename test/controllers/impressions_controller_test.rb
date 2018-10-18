require 'test_helper'

class ImpressionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @impression = impressions(:one)
  end

  test "should get index" do
    get impressions_url
    assert_response :success
  end

  test "should get new" do
    get new_impression_url
    assert_response :success
  end

  test "should create impression" do
    assert_difference('Impression.count') do
      post impressions_url, params: { impression: {  } }
    end

    assert_redirected_to impression_url(Impression.last)
  end

  test "should show impression" do
    get impression_url(@impression)
    assert_response :success
  end

  test "should get edit" do
    get edit_impression_url(@impression)
    assert_response :success
  end

  test "should update impression" do
    patch impression_url(@impression), params: { impression: {  } }
    assert_redirected_to impression_url(@impression)
  end

  test "should destroy impression" do
    assert_difference('Impression.count', -1) do
      delete impression_url(@impression)
    end

    assert_redirected_to impressions_url
  end
end
