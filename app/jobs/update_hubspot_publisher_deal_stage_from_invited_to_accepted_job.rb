class UpdateHubspotPublisherDealStageFromInvitedToAcceptedJob < ApplicationJob
  queue_as :low

  def perform(user)
    return unless ENV["HUBSPOT_PUBLISHER_AUTOMATION_ENABLED"] == "true"
    return unless user.hubspot_contact_vid
    return unless user.operational_publisher?
    return unless user.hubspot_publisher_deal

    current_stage = user.hubspot_publisher_deal_stage
    return unless current_stage && current_stage["label"] == "Invited"

    next_stage = User.hubspot_publisher_deal_pipeline_stage("Accepted")
    return unless next_stage

    user.hubspot_publisher_deal.update! dealstage: next_stage["stageId"]
  end
end
