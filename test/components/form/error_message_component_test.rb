require "test_helper"

class Form::ErrorMessageComponentTest < ViewComponent::TestCase
  setup do
    @user = users(:administrator)
  end

  test "renders nothing if no errors" do
    assert_equal("", render_inline(Form::ErrorMessageComponent.new(object: @user)).to_html.squish)
  end

  test "basic form error component with one error" do
    @user.errors.add :base, "Error"
    render_inline(Form::ErrorMessageComponent.new(object: @user))
    assert_selector("#error_explanation")
    assert_selector(".alert")
    assert_text("The form contains 1 error.")
    assert_text("Error")
  end

  test "basic form error component with multiple errors" do
    @user.errors.add :base, "Error 1"
    @user.errors.add :base, "Error 2"
    render_inline(Form::ErrorMessageComponent.new(object: @user))
    assert_selector("#error_explanation")
    assert_selector(".alert")
    assert_text("The form contains 2 errors.")
    assert_text("Error 1")
    assert_text("Error 2")
  end
end
