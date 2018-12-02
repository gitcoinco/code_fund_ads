class CreateImpressionJob < ApplicationJob
  queue_as :default

  def perform(property, campaign, ip_address, user_agent, displayed_at)
    displayed_at = Time.parse(displayed_at)

    Impression.create!(
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
      # payable: false,
      # reason: nil,
    )
  end
end
