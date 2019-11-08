module Frontend
  module ButtonHelper
    def goto_button(link: "#", icon: nil, add_class: "", target: "", title: nil, method: :get)
      link_to link,
        class: "btn btn-xs btn-icon btn-subtle-secondary #{add_class}",
        target: target,
        title: title,
        data: tooltip_expando,
        method: method do
          tag.span class: "#{icon} btn-icon__inner"
        end
    end

    def edit_button(link: "#", add_class: "")
      link_to link,
        class: "btn btn-xs btn-icon btn-subtle-secondary #{add_class}",
        data: {
          toggle: "tooltip",
          placement: "top",
          title: "Edit",
          "original-title": "Edit",
        } do
          tag.span class: "fas fa-pen btn-icon__inner"
        end
    end

    def button_panel(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "col-12 mt-5 mb-2 #{add_class}", &block)
    end
  end
end
