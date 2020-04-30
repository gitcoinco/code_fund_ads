class Card::TitleComponent < ApplicationComponent
  def initialize(classes: nil)
    @class_names = classes
  end

  private

  attr_reader :class_names

  def classes
    classes = ["card-title"]
    classes.push(class_names) unless class_names.try(:empty?)
    classes.compact
  end

  def render?
    content.present?
  end
end
