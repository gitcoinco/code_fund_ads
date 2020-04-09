module Layout
  class MainComponent < ViewComponent::Base
    def initialize(buttons: nil, datepicker: false, subject: nil, subtitle: nil, sidebar: false, tabs: false, title: nil)
      @buttons = buttons
      @datepicker = datepicker
      @sidebar = sidebar
      @subject = subject
      @subtitle = subtitle
      @tabs = tabs
      @title = title
    end

    def subject_view_directory
      subject.class.name.underscore.pluralize
    end

    private

    attr_reader :buttons, :datepicker, :subject, :subtitle, :sidebar, :tabs, :title
  end
end
