module Frontend
  module LinkHelper
    def icon_active_link(link: "#", icon: "fal fa-angle-right", text: "", active: :inclusive)
      active_link_to(
        sanitize("<i class='#{icon} fa-lg mr-2' style='width:20px;'></i> <span>#{text}</span>", tags: %w[i span], attributes: %w[style class]),
        link,
        class: "menu-link py-2",
        class_active: "has-active bg-white border-left border-primary",
        wrap_tag: :li,
        wrap_class: "menu-item",
        active: active
      )
    end
  end
end
