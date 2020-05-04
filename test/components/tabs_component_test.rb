require "test_helper"

class TabsComponentTest < ViewComponent::TestCase
  test "tabs without tab collection" do
    assert_equal("", render_inline(TabsComponent.new).to_html.squish)
  end

  test "tabs with tab collection" do
    render_inline(TabsComponent.new(tabs: [{name: "Tab", path: "https://www.example.com"}]))
    assert_selector(".nav-scroller.border-bottom.my-3")
    assert_selector(".nav.nav-tabs")
    assert_selector(".nav-link")
    assert_text("Tab")
  end

  test "tabs with classes" do
    render_inline(TabsComponent.new(classes: "foobar", tabs: [{name: "Tab", path: "https://www.example.com"}]))
    assert_selector(".nav-scroller.border-bottom.my-3.foobar")
    assert_selector(".nav.nav-tabs")
    assert_selector(".nav-link")
    assert_text("Tab")
  end
end
