class Card::HeaderComponent < ApplicationComponent
  DEFAULT_CLASSES = "card-header"

  def initialize(classes: nil)
    @class_names = classes
  end

  private

  attr_reader :class_names

  def classes
    classes = [DEFAULT_CLASSES]
    classes.push(class_names) unless class_names.try(:empty?)
    classes
  end
end
