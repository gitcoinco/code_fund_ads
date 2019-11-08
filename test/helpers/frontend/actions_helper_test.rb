require "test_helper"

module Frontend
  class ActionsHelperTest < ActionView::TestCase
    include ActionsHelper

    test "actions list" do
      output_html = "<ul class=\"nav flex-nowrap flex-shrink-1 my-auto \"></ul>"
      assert_equal output_html, actions_list
    end

    test "actions list with block" do
      output_html = "<ul class=\"nav flex-nowrap flex-shrink-1 my-auto \">foo</ul>"
      assert_equal output_html, actions_list { "foo" }
    end

    test "actions list with options" do
      output_html = "<ul id=\"id\" class=\"nav flex-nowrap flex-shrink-1 my-auto test_class\"></ul>"
      assert_equal output_html, actions_list(id: "id", add_class: "test_class")
    end

    test "actions list item" do
      output_html = "<li class=\"ml-1 \" title=\"\" data-toggle=\"tooltip\" data-placement=\"bottom\"></li>"
      assert_equal output_html, actions_list_item
    end

    test "actions list item with block" do
      output_html = "<li class=\"ml-1 \" title=\"\" data-toggle=\"tooltip\" data-placement=\"bottom\">foo</li>"
      assert_equal output_html, actions_list_item { "foo" }
    end

    test "actions list item with options" do
      output_html = "<li id=\"id\" class=\"ml-1 test_class\" title=\"title\" data-toggle=\"tooltip\" data-placement=\"bottom\"></li>"
      assert_equal output_html, actions_list_item(id: "id", title: "title", add_class: "test_class")
    end
  end
end
