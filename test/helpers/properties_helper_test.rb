require "test_helper"

class PropertiesHelperTest < ActionView::TestCase
  include PropertiesHelper

  test "property status title" do
    assert_equal "Awaiting Administrator Approval", property_status_title("pending")
    assert_equal "Active", property_status_title("active")
    assert_equal "Rejected", property_status_title("rejected")
    assert_equal "Archived", property_status_title("archived")
    assert_equal "Blacklisted", property_status_title("blacklisted")
  end
end
