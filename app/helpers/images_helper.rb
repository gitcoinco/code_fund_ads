# frozen_string_literal: true

module ImagesHelper
  def image_formats_for_select
    ENUMS::IMAGE_FORMATS.values
  end
end
