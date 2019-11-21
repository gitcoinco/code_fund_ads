require "test_helper"

class Users::PresentableTest < ActiveSupport::TestCase
  setup do
    @user = amend(users: :publisher, country: "US", region: "NC", city: "Wilmington")
    Digest::MD5.stubs(hexdigest: "1234AbCd")
  end

  test "scoped_name returns the formatted org and user name" do
    assert_equal "Acme Company·Test Publisher", @user.scoped_name
    assert_equal Encoding::UTF_8, @user.scoped_name.encoding
  end

  test "full_name returns the users first and last name" do
    assert_equal "Test Publisher", @user.full_name
  end

  test "name is an alias of full_name" do
    assert_equal @user.full_name, @user.name
  end

  test "hashed_email returns MD5 hashed email" do
    assert_equal "1234AbCd", @user.hashed_email
  end

  test "gravatar_url without options returns the correct url" do
    assert_equal "https://www.gravatar.com/avatar/1234AbCd?s=300&d=identicon", @user.gravatar_url
  end

  test "gravatar_url with display option returns the correct url" do
    assert_equal "https://www.gravatar.com/avatar/1234AbCd?s=300&d=test", @user.gravatar_url("test")
  end

  test "display_region returns 'city, region' if country is US" do
    assert_equal "Wilmington, NC", @user.display_region
  end

  test "display_region returns 'city, country' if country is not US" do
    @user.stubs(country: "GB", city: "Swindon", region: "Wiltshire")
    assert_equal "Swindon, GB", @user.display_region
  end
end
