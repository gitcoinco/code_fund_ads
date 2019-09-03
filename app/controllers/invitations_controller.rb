class InvitationsController < Devise::InvitationsController
  # PUT /resource/invitation
  def update
    super
    CreateSlackNotificationJob.perform_later text: ":email: #{resource.email} just registered via invitation" if resource.errors.empty?
  end

  def after_accept_path_for(user)
    helpers.default_dashboard_path user
  end
end
