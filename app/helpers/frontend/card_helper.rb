module Frontend
  module CardHelper
    def card(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "card mb-4 #{add_class}", &block)
    end

    def card_header(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "card-header #{add_class}", &block)
    end

    def card_body(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "card-body p-4 #{add_class}", &block)
    end

    def card_title(id: nil, add_class: "", &block)
      content_tag(:h4, nil, id: id, class: "card-title #{add_class}", &block)
    end

    def card_title_link(path: nil, id: nil, add_class: "", &block)
      link_to(path, id: id, class: "card-title h4 text-decoration-none mb-4 d-block #{add_class}", &block)
    end

    def card_subtitle(id: nil, add_class: "", &block)
      content_tag(:h6, nil, id: id, class: "card-subtitle text-muted #{add_class}", &block)
    end

    def card_text(id: nil, add_class: "", &block)
      content_tag(:p, nil, id: id, class: "card-text #{add_class}", &block)
    end

    def card_footer(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "card-footer #{add_class}", &block)
    end

    def card_footer_item(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "card-footer-item #{add_class}", &block)
    end

    def card_footer_content(id: nil, add_class: "", &block)
      content_tag(:div, nil, id: id, class: "card-footer-content text-muted #{add_class}", &block)
    end
  end
end
