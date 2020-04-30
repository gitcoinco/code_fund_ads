class ListGroupComponent < ApplicationComponent
  def initialize(bordered: false, flush: false, classes: nil)
    @bordered = bordered
    @flush = flush
    @class_names = classes
  end

  private

  attr_reader :class_names, :bordered, :flush

  def classes
    classes = ["list-group"]
    classes << "list-group-bordered" if bordered
    classes << "list-group-flush" if flush
    classes << class_names unless class_names.try(:empty?)
    classes.compact
  end

  def render?
    content.present?
  end
end
