class Emails::AttachmentComponent < ApplicationComponent
  def initialize(blob: nil)
    @blob = blob
  end

  private

  attr_reader :blob

  def render?
    blob.present?
  end
end
