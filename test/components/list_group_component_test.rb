require "test_helper"

class ListGroupComponentTest < ViewComponent::TestCase
  test "list group with no content" do
    assert_equal("", render_inline(ListGroupComponent.new).to_html.squish)
  end

  test "list group with content" do
    assert_equal(
      %(<ul class="list-group"> List Group </ul>),
      render_inline(ListGroupComponent.new) { "List Group" }.to_html.squish
    )
  end

  test "list group with classes" do
    assert_equal(
      %(<ul class="list-group foo"> List Group </ul>),
      render_inline(ListGroupComponent.new(classes: "foo")) { "List Group" }.to_html.squish
    )
  end

  test "bordered list group" do
    assert_equal(
      %(<ul class="list-group list-group-bordered"> List Group </ul>),
      render_inline(ListGroupComponent.new(bordered: true)) { "List Group" }.to_html.squish
    )
  end

  test "flush list group" do
    assert_equal(
      %(<ul class="list-group list-group-flush"> List Group </ul>),
      render_inline(ListGroupComponent.new(flush: true)) { "List Group" }.to_html.squish
    )
  end

  test "reflow list group" do
    assert_equal(
      %(<ul class="list-group list-group-reflow"> List Group </ul>),
      render_inline(ListGroupComponent.new(reflow: true)) { "List Group" }.to_html.squish
    )
  end
end
