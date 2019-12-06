module Frontend
  module ButtonHelper
    def goto_button(link: "#", icon: nil, add_class: "", target: "", title: nil, method: :get)
      link_to link,
        class: "btn btn-xs btn-icon btn-subtle-secondary #{add_class}",
        target: target,
        title: title,
        data: tooltip_expando,
        method: method do
          tag.span class: icon.to_s
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
          tag.span class: "fas fa-pen"
        end
    end

    def button_panel(id: nil, margin: "my-4", add_class: "", &block)
      content_tag(:div, nil, id: id, class: "col-12 #{margin} d-flex justify-content-end #{add_class}", &block)
    end

    def cancel_button(path, add_class: nil)
      link_to "Cancel", path, class: "btn btn-light ml-1 #{add_class}"
    end

    def layout_button(link: "#", icon: nil, add_class: "", target: "", title: nil, admin: false, method: :get, confirmation_message: nil)
      return "" if admin && !authorized_user.can_admin_system?
      link_to link,
        class: "tile layout-button #{add_class}",
        target: target,
        title: title,
        method: method do
          tag.span class: icon
        end
    end

    def destroy_button(link: "#", add_class: "", title: nil, admin: false, confirmation_message: nil, danger: true)
      return "" if admin && !authorized_user.can_admin_system?
      link_to link,
        class: "tile layout-button #{"bg-danger" if danger} #{add_class}",
        title: title,
        data: {confirm: confirmation_message || "Are you sure?"},
        method: :delete do
          tag.span class: "fas fa-trash #{"text-white" if danger}"
        end
    end
  end
end
