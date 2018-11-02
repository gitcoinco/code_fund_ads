# frozen_string_literal: true

module Imageable
  extend ActiveSupport::Concern

  included do
    has_many_attached :images
  end

  def imageable_name
    try(:name) || "#{self.class.name}: #{id}"
  end
end
