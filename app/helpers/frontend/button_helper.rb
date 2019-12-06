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

    def button_panel(id: nil, margin: "my-4", add_class: "", &block)
      content_tag(:div, nil, id: id, class: "col-12 #{margin} d-flex justify-content-end #{add_class}", &block)
    end

    def cancel_button(path, add_class: nil)
      link_to "Cancel", path, class: "btn btn-light ml-1 #{add_class}"
    end

    def layout_button(link: "#", icon: nil, add_class: "", target: "", title: nil, admin: false, method: :get)
      return "" if admin && !authorized_user.can_admin_system?
      data = method == :delete ? { confirm: "Are you sure?" } : {}
      link_to link,
        class: "tile layout-button #{add_class}",
        target: target,
        title: title,
        data: data,
        method: method do
          tag.span class: icon
        end
    end
  end
end
