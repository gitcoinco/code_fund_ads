module ImagesHelper
  def image_dimensions(image)
    "#{number_with_precision(image.blob.metadata[:width], precision: 0)}x#{number_with_precision(image.blob.metadata[:height], precision: 0)}"
  end
end
