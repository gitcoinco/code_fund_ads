class Card::FooterComponent < ApplicationComponent
  with_content_areas :actions

  def initialize(classes: nil, content: true)
    @class_names = classes
    @footer_content = content
  end

  private

  attr_reader :class_names, :footer_content

  def classes
    classes = ["card-footer"]
    classes.push(class_names) if class_names
    classes.compact
  end

  def render?
    return true if actions
    content.present?
  end
end
