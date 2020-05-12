require "test_helper"

class UtmTableComponentTest < ViewComponent::TestCase
  setup do
    @campaign = campaigns(:premium_bundled)
  end

  test "renders nothing if no errors" do
    assert_equal("", render_inline(UtmTableComponent.new(campaign: nil)).to_html.squish)
  end

  test "basic form error component with one error" do
    render_inline(UtmTableComponent.new(campaign: @campaign))
    assert_selector("table")
    assert_text(@campaign.id)
  end
end
