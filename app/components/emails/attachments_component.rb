class Emails::AttachmentsComponent < ApplicationComponent
  def initialize(classes: class_names, blobs: [])
    @class_names = class_names
    @blobs = blobs
  end

  private

  attr_reader :class_names, :blobs

  def render?
    blobs.present?
  end
end
