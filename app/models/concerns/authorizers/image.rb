module Authorizers
  module Image
    def can_update_image?(image)
      return true if can_admin_system?
      can_manage_organization?(image.record)
    end

    def can_destroy_image?(image)
      return false if ::Creative
        .joins(:creative_images)
        .where(status: :active,
               creative_images: {
                 active_storage_attachment_id: image.id
               }).exists?
      return true if can_admin_system?
      can_manage_organization?(image.record)
    end
  end
end
