class ListGroup::ItemComponent < ApplicationComponent
  def initialize(classes: nil, status: nil, data: nil)
    @class_names = classes
    @status = status
    @data = data
  end

  private

  attr_reader :class_names, :status, :data

  def classes
    classes = ["list-group-item"]
    classes.push(class_names) unless class_names.try(:empty?)
    classes << "list-group-item-#{status_color(status)}" if status
    classes.compact
  end

  def render?
    content.present?
  end
end
