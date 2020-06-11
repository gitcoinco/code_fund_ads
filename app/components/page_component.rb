class PageComponent < ApplicationComponent
  with_content_areas :header, :body

  def initialize(subject: nil, tabs: false, sidebar: false, sidebar_partial: nil, classes: [])
    @subject = subject
    @tabs = tabs
    @sidebar = sidebar
    @class_names = classes
  end

  def subject_view_directory
    return "" unless subject
    subject.class.name.underscore.pluralize
  end

  private

  attr_reader :subject, :sidebar, :tabs, :sidebar_partial, :class_names

  def classes
    classes = ["page"]
    classes << "has-sidebar has-sidebar-expand-xl" if sidebar
    classes << class_names if class_names
    classes.compact
  end
end
