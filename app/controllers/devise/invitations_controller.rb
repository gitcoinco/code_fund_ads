class Devise::InvitationsController < DeviseController
  def after_accept_path_for(user)
    UpdateHubspotPublisherDealStageFromInvitedToAcceptedJob.perform_later user
    helpers.default_dashboard_path user
  end
end
