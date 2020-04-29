require "test_helper"

class PageComponentTest < ViewComponent::TestCase
  setup do
    @user = users(:publisher)
    stub_warden(request)
  end

  test "basic page component" do
    render_inline(PageComponent.new)
    assert_selector(".page")
    assert_no_selector(".has-sidebar")
    assert_no_selector(".sidebar-backdrop")
    assert_no_selector(".page-sidebar")
    assert_no_selector(".nav-tabs-wrapper")
  end

  test "component with tabs" do
    render_inline(PageComponent.new(subject: @user, tabs: true))
    assert_selector(".page")
    assert_no_selector(".has-sidebar")
    assert_no_selector(".sidebar-backdrop")
    assert_no_selector(".page-sidebar")
    assert_selector(".nav-tabs-wrapper")
  end

  test "component with sidebar" do
    render_inline(PageComponent.new(subject: @user, sidebar: true))
    assert_selector(".page")
    assert_selector(".has-sidebar")
    assert_selector(".sidebar-backdrop")
    assert_selector(".page-sidebar")
    assert_no_selector(".nav-tabs-wrapper")
  end

  test "component with tabs and sidebar" do
    render_inline(PageComponent.new(subject: @user, sidebar: true, tabs: true))
    assert_selector(".page")
    assert_selector(".has-sidebar")
    assert_selector(".sidebar-backdrop")
    assert_selector(".page-sidebar")
    assert_selector(".nav-tabs-wrapper")
  end
end
