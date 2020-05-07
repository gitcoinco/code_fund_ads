require "test_helper"

class Card::FooterComponentTest < ViewComponent::TestCase
  test "card footer with no content" do
    assert_equal("", render_inline(Card::FooterComponent.new).to_html.squish)
  end

  test "card footer with content" do
    render_inline(Card::FooterComponent.new) { "Card Footer" }
    assert_selector(".card-footer")
    assert_selector(".card-footer-content")
    assert_text("Card Footer")
  end

  test "card footer with content classes" do
    render_inline(Card::FooterComponent.new(classes: "foo")) { "Card Footer" }
    assert_selector(".card-footer.foo")
    assert_selector(".card-footer-content")
    assert_text("Card Footer")
  end

  test "card footer with actions" do
    render_inline(Card::FooterComponent.new) { |component| component.with(:actions) { "Actions" } }
    assert_selector(".card-footer")
    assert_selector(".card-footer-content")
    assert_text("Actions")
  end
end
