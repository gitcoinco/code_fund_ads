require "test_helper"

class MetabaseComponentTest < ViewComponent::TestCase
  test "basic metabase component" do
    render_inline(MetabaseComponent.new(src: "https://www.example.com"))
    assert_selector(".metabase-card")
    assert_selector("[title='Metabase dashboard']")
    assert_selector("[height='800']")
    assert_selector("[src='https://www.example.com']")
  end

  test "component with specific height" do
    render_inline(MetabaseComponent.new(src: "https://www.example.com", height: 1000))
    assert_selector(".metabase-card")
    assert_selector("[title='Metabase dashboard']")
    assert_selector("[height='1000']")
    assert_selector("[src='https://www.example.com']")
  end

  test "component with specific title" do
    render_inline(MetabaseComponent.new(src: "https://www.example.com", title: "title"))
    assert_selector(".metabase-card")
    assert_selector("[title='title']")
    assert_selector("[height='800']")
    assert_selector("[src='https://www.example.com']")
  end
end
