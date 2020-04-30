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
end
