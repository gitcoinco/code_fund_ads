require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "#pretty_url" do
    assert_nil pretty_url("")
    assert_nil pretty_url(nil)
    assert_equal "codefund.io", pretty_url("https://www.codefund.io")
    assert_equal "codefund.io", pretty_url("https://www.codefund.io/index.html")
    assert_equal "codefund.io", pretty_url("https://codefund.io/blog/300-million-ethical-ads")
  end
end
