class Tabs::TabComponent < ApplicationComponent
  def initialize(tab:)
    @tab = tab
  end

  def call
    tag.li(active_link_to(name, path, active: active, data: tab_link_data, class: "nav-link")) if validation
  end

  private

  attr_reader :tab

  def name
    tab[:name]
  end

  def path
    tab[:path]
  end

  def active
    tab.fetch(:active, nil)
  end

  def validation
    tab.fetch(:validation, true)
  end

  def type
    tab.fetch(:type, "link")
  end

  def tab_link_data
    if type.inquiry.tab?
      {toggle: "tab"}
    else
      {turbolinks_persist_scroll: true, prefetch: true}
    end
  end
end
