# frozen_string_literal: true

class Image
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :attachment

  delegated_methods = %i[
    byte_size
    checksum
    content_type
    filename
    id
    persisted?
    record
    variant
  ]

  delegate *delegated_methods, to: :attachment

  def initialize(active_storage_attachment)
    @attachment = active_storage_attachment
  end

  def name
    attachment.blob.metadata[:name]
  end

  def description
    attachment.blob.metadata[:description]
  end

  def format
    attachment.blob.metadata[:format]
  end

  def width
    attachment.blob.metadata[:width]
  end

  def height
    attachment.blob.metadata[:height]
  end
end
