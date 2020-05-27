require "test_helper"

class CardComponentTest < ViewComponent::TestCase
  test "card with no content" do
    assert_equal("", render_inline(CardComponent.new).to_html.squish)
  end

  test "card with content" do
    assert_equal(
      %(<div class="card"> Card </div>),
      render_inline(CardComponent.new) { "Card" }.to_html.squish
    )
  end

  test "card with classes" do
    assert_equal(
      %(<div class="card mb-1 mt-2"> Card </div>),
      render_inline(CardComponent.new(classes: "mb-1 mt-2")) { "Card" }.to_html.squish
    )
  end
end
