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
    variant
  ]

  delegate *delegated_methods, to: :attachment

  def initialize(active_storage_attachment)
    @attachment = active_storage_attachment
  end

  def meta_name
    attachment.blob.metadata[:name]
  end

  def meta_description
    attachment.blob.metadata[:description]
  end

  def meta_format
    attachment.blob.metadata[:format]
  end

  def meta_width
    attachment.blob.metadata[:width]
  end

  def meta_height
    attachment.blob.metadata[:height]
  end
end
