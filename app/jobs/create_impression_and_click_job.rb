class CreateImpressionAndClickJob < ApplicationJob
  queue_as :click

  def perform(campaign_id, property_id, ip_address, user_agent, clicked_at_string)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign&.sponsor?

    property = Property.find_by(id: property_id)
    return unless property

    creative = campaign.sponsor_creatives.first # note: we don't know the creative that was shown
    clicked_at = Time.parse(clicked_at_string)

    ip_info = MMDB.lookup(ip_address)
    country_code = Country.find(ip_info&.country&.iso_code)&.iso_code
    subdivision = ip_info&.subdivisions&.first&.iso_code
    province_code = Province.find("#{country_code}-#{subdivision}")&.iso_code

    impression = Impression.create!(
      id: SecureRandom.uuid,
      advertiser_id: campaign.user_id,
      publisher_id: property.user_id,
      organization_id: campaign.organization_id,
      campaign: campaign,
      creative: creative,
      property: property,
      ip_address: ip_address, # NOTE: obfuscated via an Impression model callback
      user_agent: user_agent,
      displayed_at: clicked_at, # note: don't know when the ad was first displayed
      displayed_at_date: clicked_at.to_date,
      clicked_at: clicked_at,
      clicked_at_date: clicked_at.to_date,
      fallback_campaign: campaign.fallback?,
      country_code: country_code,
      province_code: province_code,
      postal_code: ip_info&.postal&.code,
      latitude: ip_info&.location&.latitude,
      longitude: ip_info&.location&.longitude
    )

    impression.track_event :impression_clicked
  end
end
