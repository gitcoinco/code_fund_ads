class CreateImpressionJob < ApplicationJob
  queue_as :impression

  def perform(id, campaign_id, property_id, ad_template, ad_theme, ip_address, user_agent, displayed_at_string, uplift = "false")
    @event_id = SecureRandom.uuid
    @ip_address = ip_address

    campaign = Campaign.find_by(id: campaign_id)
    property = Property.find_by(id: property_id)

    unless campaign && property
      track_event({status: "missing_campaign_and_property"})
    end

    displayed_at = Time.parse(displayed_at_string)
    ip_info = MMDB.lookup(ip_address)
    country_code = Country.find(ip_info&.country&.iso_code)&.iso_code
    subdivision = ip_info&.subdivisions&.first&.iso_code
    province_code = Province.find("#{country_code}-#{subdivision}")&.iso_code if country_code.present? && subdivision.present?

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
      uplift: uplift.to_s == "true",
      ip_address: ip_address,
      user_agent: user_agent,
      displayed_at: displayed_at,
      displayed_at_date: displayed_at.to_date,
      fallback_campaign: campaign.fallback?,
      country_code: country_code,
      province_code: province_code,
      postal_code: ip_info&.postal&.code,
      latitude: ip_info&.location&.latitude,
      longitude: ip_info&.location&.longitude
    )

    IncrementImpressionsCountCacheJob.perform_now impression
    track_event({
      status: "success",
      campaign_id: campaign.id,
      creative_id: campaign.creative_id,
      property_id: property.id,
      country_code: impression.country_code.to_s,
    })
  rescue ActiveRecord::RecordNotUnique
    # prevent reattempts when a race condition attempts to write the same record
    track_event({status: "record_not_unique"})
  end

  private

  def track_event(data)
    CodeFundAds::Events.track("Create Impression", @event_id, {ip_address: @ip_address}.merge(data))
  end
end
