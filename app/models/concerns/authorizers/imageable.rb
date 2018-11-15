# frozen_string_literal: true

module Authorizers
  module Imageable
    def can_view_imageable?(imageable)
      return true if can_admin_system?
      user == imageable
    end
  end
end
