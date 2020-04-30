class Card::FooterItemComponent < ApplicationComponent
  def initialize(classes: nil, bordered: false, muted: true)
    @class_names = classes
    @bordered = bordered
    @muted = muted
  end

  private

  attr_reader :class_names, :bordered, :muted

  def classes
    classes = ["card-footer-item"]
    classes << "card-footer-item-bordered" if bordered
    classes << "text-muted" if muted
    classes.push(class_names) unless class_names.try(:empty?)
    classes.compact
  end

  def render?
    content.present?
  end
end
