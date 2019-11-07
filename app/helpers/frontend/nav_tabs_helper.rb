module Frontend
  module NavTabsHelper
    def nav_tabs(id: nil, add_class: "", &block)
      content_tag(:ul, nil, id: id, class: "nav nav-tabs #{add_class}", &block)
    end

    def nav_item_link(name: nil, id: nil, path: nil, active: nil, type: "link")
      tag.li(active_link_to(name, path, id: id, active: active, data: nav_item_link_data(type), class: "nav-link"))
    end

    private

    def nav_item_link_data(type)
      if type.inquiry.tab?
        {toggle: "tab"}
      else
        {turbolinks_persist_scroll: true, prefetch: true}
      end
    end
  end
end
