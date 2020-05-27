require "test_helper"
require_relative "../../app/helpers/users_helper"

class PageComponentTest < ViewComponent::TestCase
  include UsersHelper
  include Rails.application.routes.url_helpers

  def authorized_user
    AuthorizedUser.new(@user)
  end

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
    assert_no_selector(".nav-scroller")
  end

  test "component with classes" do
    render_inline(PageComponent.new(classes: "mb-4"))
    assert_selector(".page.mb-4")
    assert_no_selector(".has-sidebar")
    assert_no_selector(".sidebar-backdrop")
    assert_no_selector(".page-sidebar")
    assert_no_selector(".nav-scroller")
  end

  test "component with tabs" do
    render_inline(PageComponent.new(subject: @user, tabs: TabsComponent.new(tabs: user_tabs(@user))))
    assert_selector(".page")
    assert_no_selector(".has-sidebar")
    assert_no_selector(".sidebar-backdrop")
    assert_no_selector(".page-sidebar")
    assert_selector(".nav-scroller")
  end

  test "component with sidebar" do
    render_inline(PageComponent.new(subject: @user, sidebar: true))
    assert_selector(".page")
    assert_selector(".has-sidebar")
    assert_selector(".sidebar-backdrop")
    assert_selector(".page-sidebar")
    assert_no_selector(".nav-scroller")
  end

  test "component with tabs and sidebar" do
    render_inline(PageComponent.new(subject: @user, sidebar: true, tabs: TabsComponent.new(tabs: user_tabs(@user))))
    assert_selector(".page")
    assert_selector(".has-sidebar")
    assert_selector(".sidebar-backdrop")
    assert_selector(".page-sidebar")
    assert_selector(".nav-scroller")
  end
end
