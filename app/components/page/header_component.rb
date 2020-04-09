class Page::HeaderComponent < ViewComponent::Base
  def initialize(title: nil, subtitle: nil, buttons: [], datepicker: false, sidebar: false)
    @title = title
    @subtitle = subtitle
    @buttons = buttons
    @datepicker = datepicker
    @sidebar = sidebar
  end

  private

  attr_reader :title, :subtitle, :buttons, :datepicker, :sidebar
end
