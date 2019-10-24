module ButtonHelper
  def button_panel(id: nil, add_class: "", &block)
    content_tag(:div, nil, id: id, class: "col-12 mt-5 mb-2 #{add_class}", &block)
  end
end
