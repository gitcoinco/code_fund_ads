require "test_helper"

class Card::HeaderComponentTest < ViewComponent::TestCase
  test "card header with no content" do
    assert_equal("", render_inline(Card::HeaderComponent.new).to_html.squish)
  end

  test "card header with content" do
    assert_equal(
      %(<div class="card-header"> Card Header </div>),
      render_inline(Card::HeaderComponent.new) { "Card Header" }.to_html.squish
    )
  end

  test "card header with classes" do
    assert_equal(
      %(<div class="card-header foo"> Card Header </div>),
      render_inline(Card::HeaderComponent.new(classes: "foo")) { "Card Header" }.to_html.squish
    )
  end
end
