require "test_helper"

class Card::SubtitleComponentTest < ViewComponent::TestCase
  test "card subtitle with no content" do
    assert_equal("", render_inline(Card::SubtitleComponent.new).to_html.squish)
  end

  test "card subtitle with content" do
    assert_equal(
      %(<h6 class="card-subtitle text-muted"> Card Subtitle </h6>),
      render_inline(Card::SubtitleComponent.new) { "Card Subtitle" }.to_html.squish
    )
  end

  test "card subtitle with classes" do
    assert_equal(
      %(<h6 class="card-subtitle text-muted foo"> Card Subtitle </h6>),
      render_inline(Card::SubtitleComponent.new(classes: "foo")) { "Card Subtitle" }.to_html.squish
    )
  end
end
