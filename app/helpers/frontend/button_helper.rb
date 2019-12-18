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

    def button_panel(id: nil, margin: "my-4", add_class: "", &block)
      content_tag(:div, nil, id: id, class: "col-12 #{margin} d-flex justify-content-end #{add_class}", &block)
    end

    def cancel_button(path, add_class: nil)
      link_to "Cancel", path, class: "btn btn-light ml-1 #{add_class}"
    end

    def layout_button(link: "#", icon: nil, add_class: "", target: "", title: nil, admin: false, method: :get, confirmation_message: nil, permissions: true)
      return "" if admin && !authorized_user.can_admin_system?
      return "" unless permissions

      link_to link,
        class: "tile layout-button #{add_class}",
        target: target,
        title: title,
        method: method do
          tag.span class: icon
        end
    end

    def edit_button(link: "#", title: nil, add_class: "", admin: false)
      return "" if admin && !authorized_user.can_admin_system?
      link_to link,
        class: "btn btn-xs btn-icon btn-subtle-secondary #{add_class}",
        title: title do
          tag.span class: "fas fa-pen"
        end
    end

    def delete_button(link: "#", add_class: "", title: nil, admin: false, confirmation_message: "Are you sure?", layout: false)
      return "" if admin && !authorized_user.can_admin_system?
      classes = layout ? "bg-danger tile layout-button" : "btn btn-xs btn-icon btn-subtle-secondary"
      link_to link,
        class: "#{classes} #{add_class}",
        title: title,
        data: {confirm: confirmation_message},
        method: :delete do
          tag.span class: "fas fa-trash #{layout ? "text-white" : "text-subtle"}"
        end
    end
  end
end
