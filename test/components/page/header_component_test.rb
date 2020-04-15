require "test_helper"

class Page::HeaderComponentTest < ViewComponent::TestCase
  test "component with title" do
    render_inline(Page::HeaderComponent.new(title: "Title Text"))
    assert_selector(".page-title-bar")
    assert_text("Title Text")
    assert_no_selector("[onclick='CodeFundTheme.toggleSidebar()']")
  end

  test "component with subtitle" do
    render_inline(Page::HeaderComponent.new(subtitle: "Subtitle Text"))
    assert_selector(".page-title-bar")
    assert_text("Subtitle Text")
    assert_no_selector("[onclick='CodeFundTheme.toggleSidebar()']")
  end

  test "component with sidebar" do
    render_inline(Page::HeaderComponent.new(sidebar: true))
    assert_selector(".page-title-bar")
    assert_selector("[onclick='CodeFundTheme.toggleSidebar()']")
  end
end
