class Page::HeaderComponent < ViewComponent::Base
  def initialize(title: nil, subtitle: nil, buttons: [], datepicker: false, sidebar: false, back_link: nil)
    @title = title
    @subtitle = subtitle
    @buttons = buttons
    @datepicker = datepicker
    @sidebar = sidebar
    @back_link = back_link
  end

  private

  attr_reader :title, :subtitle, :buttons, :datepicker, :sidebar, :back_link
end
