class UpdateHubspotDealJob < ApplicationJob
  queue_as :low

  def perform(deal_vid, stage_id)
    return unless ENV["HUBSPOT_ENABLED"] == "true"

    deal = Hubspot::Deal.find(deal_vid)
    deal&.update!({dealstage: stage_id})
  end
end
