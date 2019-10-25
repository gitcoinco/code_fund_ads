module ActionsHelper
  def actions_list(id: nil, add_class: "", &block)
    content_tag(:ul, nil, id: id, class: "nav flex-nowrap flex-shrink-1 my-auto #{add_class}", &block)
  end

  def actions_list_item(id: nil, title: "", add_class: "", &block)
    content_tag(:li,
      nil,
      id: id,
      class: "ml-1 #{add_class}",
      title: title,
      "data-toggle": "tooltip",
      "data-placement": "bottom",
      &block)
  end

  def actions_date_range_picker(id: nil, add_class: "")
    content_tag :li, nil, id: id, class: add_class do
      render "/shared/date_range_picker"
    end
  end
end
