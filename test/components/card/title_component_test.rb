require "test_helper"

class Card::TitleComponentTest < ViewComponent::TestCase
  test "card title with no content" do
    assert_equal("", render_inline(Card::TitleComponent.new).to_html.squish)
  end

  test "card title with content" do
    assert_equal(
      %(<h4 class="card-title"> Card Title </h4>),
      render_inline(Card::TitleComponent.new) { "Card Title" }.to_html.squish
    )
  end

  test "card title with classes" do
    assert_equal(
      %(<h4 class="card-title foo"> Card Title </h4>),
      render_inline(Card::TitleComponent.new(classes: "foo")) { "Card Title" }.to_html.squish
    )
  end
end
