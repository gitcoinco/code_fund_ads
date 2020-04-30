class Card::BodyComponent < ApplicationComponent
  def initialize(classes: nil, styles: nil)
    @class_names = classes
    @styles = styles
  end

  private

  attr_reader :class_names, :styles

  def classes
    classes = ["card-body p-4"]
    classes.push(class_names) unless class_names.try(:empty?)
    classes
  end
end
