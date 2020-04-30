require "test_helper"

class Card::BodyComponentTest < ViewComponent::TestCase
  test "card body with no content" do
    assert_equal("", render_inline(Card::BodyComponent.new).to_html.squish)
  end

  test "card body with content" do
    assert_equal(
      %(<div class="card-body p-4"> Card Body </div>),
      render_inline(Card::BodyComponent.new) { "Card Body" }.to_html.squish
    )
  end

  test "card body with classes" do
    assert_equal(
      %(<div class="card-body p-4 foo"> Card Body </div>),
      render_inline(Card::BodyComponent.new(classes: "foo")) { "Card Body" }.to_html.squish
    )
  end

  test "card body with styles" do
    assert_equal(
      %(<div class="card-body p-4" style="height:100%;"> Card Body </div>),
      render_inline(Card::BodyComponent.new(styles: "height:100%;")) { "Card Body" }.to_html.squish
    )
  end
end
