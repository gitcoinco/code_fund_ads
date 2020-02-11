class InvitationsController < Devise::InvitationsController
  layout :resolve_layout
  after_action :create_organization_user, only: :create

  def update
    super
    CreateSlackNotificationJob.perform_later text: ":email: #{resource.email} just registered via invitation" if resource.errors.empty?
  end

  def new
    self.resource = resource_class.new
    render :new
  end

  def after_accept_path_for(user)
    helpers.default_dashboard_path user
  end

  def after_invite_path_for(_inviter, _invitee = nil)
    users_path
  end

  private

  def create_organization_user
    org = Organization.find_by(id: invite_params.dig(:organization_id))
    return unless org
    OrganizationUser.find_or_create_by(organization: org, user: resource)
  end

  def resolve_layout
    case action_name
    when "new"
      "application"
    when "create"
      "application"
    else
      "authentication"
    end
  end
end
