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
      link_to "Cancel", path, class: "btn btn-light mr-1 #{add_class}"
    end

    def generate_organization_report_button(id)
      return "" unless authorized_user.can_admin_system?
      button_tag("Generate Reports", data: {reflex: "click->OrganizationReportsReflex#generate", id: id, controller: "organization-reports"}, class: "ml-1 btn btn-primary", style: "height:2.5rem;")
    end

    def layout_button(link: "#", icon: nil, add_class: "", target: "", title: nil, admin: false, method: :get, confirmation_message: nil, display: true)
      return "" unless display
      return "" if admin && !authorized_user.can_admin_system?

      link_to link,
        class: "tile layout-button #{add_class}",
        target: target,
        title: title,
        method: method do
          tag.span class: icon
        end
    end

    def masquerade_button(user, add_class: "")
      return "" unless authorized_user.can_admin_system?
      link_to(user_impersonation_path(user),
        class: "btn btn-xs btn-icon btn-subtle-secondary #{add_class}",
        title: "Masquerade as user",
        data: tooltip_expando,
        method: :put) { tag.span(class: "fad fa-mask") }
    end

    def edit_button(link: "#", title: nil, add_class: "", admin: false)
      return "" if admin && !authorized_user.can_admin_system?
      link_to(link,
        class: "btn btn-xs btn-icon btn-subtle-secondary #{add_class}",
        title: title,
        data: tooltip_expando) { tag.span class: "fas fa-pen" }
    end

    def delete_button(link: "#", add_class: "", title: nil, admin: false, confirmation_message: "Are you sure?", layout: false, display: true)
      return "" unless display
      return "" if admin && !authorized_user.can_admin_system?

      classes = layout ? "bg-danger tile layout-button" : "btn btn-xs btn-icon btn-subtle-secondary"
      link_to(link,
        class: "#{classes} #{add_class}",
        title: title,
        data: {confirm: confirmation_message, toggle: "tooltip", placement: "top"},
        method: :delete) { tag.span class: "fas fa-trash #{layout ? "text-white" : "text-subtle"}" }
    end
  end
end
