module Frontend
  module IconHelper
    def icon(icon, id: nil, add_class: "", &block)
      content_tag(:i, nil, id: id, class: "#{icon} #{add_class}", &block)
    end

    def current_sort_direction_icon
      direction = session[:sort_direction] == "desc" ? "up" : "down"
      tag.span class: "fas fa-arrow-#{direction} mr-1"
    end
  end
end
