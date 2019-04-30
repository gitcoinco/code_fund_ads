class UpdateHubspotPublisherDealStagesFromAcceptedToIntegratedJob < ApplicationJob
  queue_as :low

  def perform
    User.publishers.find_each do |user|
      next unless user.hubspot_contact_vid
      UpdateHubspotPublisherDealStageFromAcceptedToIntegratedJob.perform_later user
    end
  end
end
