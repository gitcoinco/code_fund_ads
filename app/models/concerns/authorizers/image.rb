module Authorizers
  module Image
    def can_update_image?(image)
      return true if can_admin_system?
      image.record == user
    end

    def can_destroy_image?(image)
      return true if can_admin_system?
      image.record == user
    end
  end
end
