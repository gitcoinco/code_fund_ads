module NavTabsHelper
  def nav_tabs(id: nil, add_class: "", &block)
    content_tag(:ul, nil, id: id, class: "nav nav-tabs #{add_class}", &block)
  end

  def nav_item_link(name: nil, path: nil, active: nil)
    tag.li(active_link_to(name, path, active: active, data: {
      turbolinks_persist_scroll: true,
      prefetch: true,
    }, class: "nav-link"))
  end
end
