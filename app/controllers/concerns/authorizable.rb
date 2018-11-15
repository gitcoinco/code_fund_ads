# frozen_string_literal: true

# Makes all authorizers defined under app/authorizers available to controllers and views.
#
# Authorizers are exposed via methods sharing the same name as the filename.
# They are lazily initialized with `current_user` and memoized.
#
# Examples (from within a controller or view template):
#
#   users_authorizer.can_admin_system?
#   imageable_authorizer.can_view_images?(User.first)
#   images_authorizer.can_update?(User.first.images.first)
#
module Authorizable
  extend ActiveSupport::Concern

  authorizers = Dir[Rails.root.join("app/authorizers/*_authorizer.rb")].each_with_object({}) do |path, memo|
    name = path.split("/").last.delete_suffix(".rb")
    memo[name] = name.classify.constantize
  end

  authorizers.each do |name, klass|
    define_method name do
      authorizer = instance_variable_get(:"@#{name}")
      authorizer ||= klass.new(current_user)
      instance_variable_set(:"@#{name}", authorizer)
    end
  end

  included do
    authorizers.keys.each { |name| helper_method name }
  end
end
