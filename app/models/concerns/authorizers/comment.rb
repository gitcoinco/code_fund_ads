# As of now, only system admins can perform CRUD operations on comments
# This file is layed out this way to make opening up comment functionality easier in the future

module Authorizers
  module Comment
    def can_create_comment?
      return true if can_admin_system?
      false
    end

    def can_destroy_comment?
      return true if can_admin_system?
      false
    end

    def can_view_comments?
      return true if can_admin_system?
      false
    end
  end
end
