require "test_helper"

class Comments::FormComponentTest < ViewComponent::TestCase
  setup do
    Capybara.ignore_hidden_elements = false
    @commentable = organizations(:default)
  end

  test "basic comments form component" do
    render_inline(Comments::FormComponent.new(commentable: @commentable))
    assert_selector("form")
    assert_selector("[name='comment[sgid]']")
    assert_selector("[name='comment[body]']")
  end
end
