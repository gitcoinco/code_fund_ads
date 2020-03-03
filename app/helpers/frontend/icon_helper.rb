module Frontend
  module IconHelper
    def icon(icon, id: nil, add_class: "", &block)
      content_tag(:i, nil, id: id, class: "#{icon} #{add_class}", &block)
    end

    def current_sort_direction_icon
      direction = session[:sort_direction] || @sort_direction
      tag.span class: "fas fa-arrow-#{direction == "desc" ? "up" : "down"} mr-1"
    end
  end
end
