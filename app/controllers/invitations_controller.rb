class InvitationsController < Devise::InvitationsController
  layout "authentication"
  after_action :create_organization_user, only: :create

  def update
    super
    CreateSlackNotificationJob.perform_later text: ":email: #{resource.email} just registered via invitation" if resource.errors.empty?
  end

  def new
    self.resource = resource_class.new
    render :new, layout: "application"
  end

  def after_accept_path_for(user)
    helpers.default_dashboard_path user
  end

  private

  def create_organization_user
    org = Organization.find(invite_params.dig(:organization_id))
    OrganizationUser.find_or_create_by(organization: org, user: resource)
  end
end
