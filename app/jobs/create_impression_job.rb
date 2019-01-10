class CreateImpressionJob < ApplicationJob
  queue_as :impression

  def perform(id, campaign_id, property_id, ad_template, ad_theme, ip_address, user_agent, displayed_at_string)
    campaign = Campaign.find_by(id: campaign_id)
    property = Property.find_by(id: property_id)

    unless campaign && property
      statsd_increment(["sidekiq", "CreateImpressionJob", "perform", "missing_campaign_and_property"].join("."))
      return
    end

    displayed_at = Time.parse(displayed_at_string)
    ip_info = MMDB.lookup(ip_address)

    impression = Impression.create!(
      id: id,
      advertiser_id: campaign.user_id,
      publisher_id: property.user_id,
      organization_id: campaign.organization_id,
      campaign: campaign,
      creative_id: campaign.creative_id,
      property: property,
      ad_template: ad_template,
      ad_theme: ad_theme,
      ip_address: ip_address,
      user_agent: user_agent,
      displayed_at: displayed_at,
      displayed_at_date: displayed_at.to_date,
      fallback_campaign: campaign.fallback?,
      country_code: ip_info&.country&.iso_code,
      postal_code: ip_info&.postal&.code,
      latitude: ip_info&.location&.latitude,
      longitude: ip_info&.location&.longitude
    )

    statsd_increment([
      "sidekiq",
      "CreateImpressionJob",
      "perform",
      "create_impression",
      campaign.id,
      property.id,
      campaign.creative_id,
      impression.country_code,
      campaign.fallback?,
    ].join("."))

    IncrementImpressionsCountCacheJob.perform_now impression
  rescue ActiveRecord::RecordNotUnique
    # prevent reattempts when a race condition attempts to write the same record
    statsd_increment(["sidekiq", "CreateImpressionJob", "perform", "record_not_unique"].join("."))
  end
end
