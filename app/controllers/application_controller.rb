class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authorizable
  include Dateable

  delegate :instrument, to: ActiveSupport::Notifications

  before_action :reload_extensions, unless: -> { Rails.env.production? }
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  impersonates :user

  protected

  def authenticate_administrator!
    return render_forbidden unless AuthorizedUser.new(current_user || User.new).can_admin_system?
  end

  def render_not_found
    render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
  end

  def render_forbidden
    render file: Rails.public_path.join("403.html"), status: :forbidden, layout: false
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :organization_id, roles: []])
  end

  def after_invite_path_for(_inviter, _invitee = nil)
    users_path
  end

  def reload_extensions
    load Rails.root.join("app/lib/extensions.rb")
  end
end
