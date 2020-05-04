class ListGroup::ItemComponent < ApplicationComponent
  def initialize(classes: nil, status: nil, data: nil, label: nil)
    @class_names = classes
    @status = status
    @data = data
    @label = label
  end

  private

  attr_reader :class_names, :status, :data, :label

  def classes
    classes = ["list-group-item text-body"]
    classes.push(class_names) if class_names
    classes << "list-group-item-#{status_color(status)}" if status
    classes << "d-flex justify-content-between align-items-center" if label
    classes.compact
  end

  def render?
    content.present?
  end
end
