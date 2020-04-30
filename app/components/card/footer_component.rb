class Card::FooterComponent < ApplicationComponent
  with_content_areas :actions

  def initialize(classes: nil)
    @class_names = classes
  end

  private

  attr_reader :class_names

  def classes
    classes = ["card-footer"]
    classes.push(class_names) unless class_names.try(:empty?)
    classes.compact
  end

  def render?
    return true if actions
    content.present?
  end
end
