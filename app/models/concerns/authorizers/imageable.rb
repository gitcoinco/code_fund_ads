module Authorizers
  module Imageable
    def can_view_imageable?(imageable)
      return true if can_admin_system?
      can_manage_organization?(imageable)
    end

    def can_upload_imageables?
      return true if can_admin_system? || can_advertise?
      false
    end
  end
end
