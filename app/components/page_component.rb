class PageComponent < ViewComponent::Base
  with_content_areas :header, :body

  def initialize(subject: nil, tabs: false, sidebar: false)
    @subject = subject
    @tabs = tabs
    @sidebar = sidebar
  end

  def subject_view_directory
    subject&.class&.name&.underscore&.pluralize
  end

  private

  attr_reader :subject, :sidebar, :tabs
end
