require "test_helper"

class Card::FooterItemComponentTest < ViewComponent::TestCase
  test "card footer item with no content" do
    assert_equal("", render_inline(Card::FooterItemComponent.new).to_html.squish)
  end

  test "card footer item with content" do
    assert_equal(
      %(<div class="card-footer-item text-muted"> Card Footer Item </div>),
      render_inline(Card::FooterItemComponent.new) { "Card Footer Item" }.to_html.squish
    )
  end

  test "card footer item with classes" do
    assert_equal(
      %(<div class="card-footer-item text-muted foo"> Card Footer Item </div>),
      render_inline(Card::FooterItemComponent.new(classes: "foo")) { "Card Footer Item" }.to_html.squish
    )
  end

  test "bordered card footer item" do
    assert_equal(
      %(<div class="card-footer-item card-footer-item-bordered text-muted"> Card Footer Item </div>),
      render_inline(Card::FooterItemComponent.new(bordered: true)) { "Card Footer Item" }.to_html.squish
    )
  end

  test "non-muted card footer item" do
    assert_equal(
      %(<div class="card-footer-item"> Card Footer Item </div>),
      render_inline(Card::FooterItemComponent.new(muted: false)) { "Card Footer Item" }.to_html.squish
    )
  end
end
