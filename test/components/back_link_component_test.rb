require "test_helper"

class BackLinkComponentTest < ViewComponent::TestCase
  test "component renders" do
    result = render_inline(BackLinkComponent.new(title: "TITLE", link: "LINK"))
    assert_selector("ol.breadcrumb")
    assert_selector("a[href=LINK]")
    assert_includes result.css("a[href=LINK]").to_html, "TITLE"
  end
end
