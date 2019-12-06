module Authorizers
  module Image
    def can_update_image?(image)
      true
    end

    def can_destroy_image?(image)
      return true unless ::Creative
        .joins(:creative_images)
        .where(status: :active,
               creative_images: {
                 active_storage_attachment_id: image.id,
               }).exists?
    end
  end
end
