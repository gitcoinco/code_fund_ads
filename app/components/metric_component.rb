class MetricComponent < ApplicationComponent
  def initialize(classes: nil, bordered: false, card: false, title: nil, subtitle: nil, value: nil)
    @classes = classes
    @bordered = bordered
    @card = card
    @title = title
    @subtitle = subtitle
    @value = value
  end

  private

  attr_reader :classes, :bordered, :card, :title, :subtitle, :value

  def classes
    classes = ["metric"]
    classes << "metric-bordered" if bordered
    classes << class_names unless class_names.try(:empty?)
    classes.compact
  end

  # def render?
  #   content.present?
  # end
end
