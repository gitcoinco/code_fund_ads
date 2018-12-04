class CreateImpressionJob < ApplicationJob
  queue_as :default

  def perform(id, campaign_id, property_id, ip_address, user_agent, displayed_at_string)
    campaign = Campaign.find_by(id: campaign_id)
    property = Property.find_by(id: property_id)
    return unless campaign && property
    displayed_at = Time.parse(displayed_at_string)

    impression = Impression.create!(
      id: id,
      advertiser_id: campaign.user_id,
      campaign: campaign,
      campaign_name: campaign.scoped_name,
      property: property,
      property_name: property_name.scoped_name,
      ip_address: ip_address,
      user_agent: user_agent,
      displayed_at: displayed_at,
      displayed_at_date: displayed_at.to_date,
      fallback_campaign: campaign.fallback?,
      # TODO: set the following keys/values
      # country_code: nil,
      # postal_code: nil,
      # latitude: nil,
      # longitude: nil,
      # reason: nil,
    )

    IncrementImpressionsCountCacheJob.perform_now impression
  end
end
