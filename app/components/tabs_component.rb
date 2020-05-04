class TabsComponent < ApplicationComponent
  def initialize(classes: nil, tabs: nil)
    @class_names = classes
    @tabs = tabs
  end

  private

  attr_reader :class_names, :tabs

  def classes
    classes = ["nav-scroller border-bottom my-3"]
    classes << class_names if class_names
    classes.compact
  end

  def render?
    tabs&.any?
  end
end
