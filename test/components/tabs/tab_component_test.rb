require "test_helper"

class Tabs::TabComponentTest < ViewComponent::TestCase
  test "tab that fails validation" do
    assert_equal("", render_inline(Tabs::TabComponent.new(tab: {validation: false})).to_html.squish)
  end

  test "tab as link" do
    tab = {
      name: "Tab",
      path: "https://www.example.com",
      active: :exact,
      validation: true != false,
      type: "link"
    }

    render_inline(Tabs::TabComponent.new(tab: tab))
    assert_selector("li")
    assert_selector(".nav-link")
    assert_no_selector("[toggle='tab']")
    assert_selector("[data-turbolinks-persist-scroll='true']")
    assert_selector("[data-prefetch='true']")
    assert_selector("[href='https://www.example.com']")
    assert_text("Tab")
  end

  test "tab as tab" do
    tab = {
      name: "Tab",
      path: "https://www.example.com",
      active: :exact,
      validation: true != false,
      type: "tab"
    }

    render_inline(Tabs::TabComponent.new(tab: tab))
    assert_selector("li")
    assert_selector(".nav-link")
    assert_selector("[data-toggle='tab']")
    assert_no_selector("[data-turbolinks-persist-scroll='true']")
    assert_no_selector("[data-prefetch='true']")
    assert_selector("[href='https://www.example.com']")
    assert_text("Tab")
  end
end
