class ListGroupComponent < ApplicationComponent
  def initialize(bordered: false, flush: false, reflow: false, classes: nil, messages: nil)
    @bordered = bordered
    @flush = flush
    @reflow = reflow
    @messages = messages
    @class_names = classes
  end

  private

  attr_reader :class_names, :bordered, :flush, :reflow, :messages

  def classes
    classes = ["list-group"]
    classes << "list-group-bordered" if bordered
    classes << "list-group-flush" if flush
    classes << "list-group-reflow" if reflow
    classes << "list-group-reflow" if messages
    classes << class_names if class_names
    classes.compact
  end

  def render?
    content.present?
  end
end
