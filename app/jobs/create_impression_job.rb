class CreateImpressionJob < ApplicationJob
  queue_as :impression

  def perform(id, campaign_id, property_id, creative_id, ad_template, ad_theme, ip_address, country_code, user_agent, displayed_at_string)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    return unless user_agent

    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign&.standard?

    property = Property.find_by(id: property_id)
    return unless property

    displayed_at = Time.parse(displayed_at_string)
    ip_info = Mmdb.lookup(ip_address)
    subdivision = ip_info&.subdivisions&.first&.iso_code
    province_code = Province.find("#{country_code}-#{subdivision}")&.iso_code

    impression = Impression.create!(
      id: id,
      advertiser_id: campaign.user_id,
      publisher_id: property.user_id,
      organization_id: campaign.organization_id,
      campaign: campaign,
      creative_id: creative_id,
      property: property,
      ad_template: ad_template,
      ad_theme: ad_theme,
      ip_address: ip_address, # NOTE: obfuscated via an Impression model callback
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

    campaign.increment_hourly_consumed_budget_fractional_cents impression.estimated_gross_revenue_fractional_cents
    impression.track_event :impression_created
  rescue ActiveRecord::RecordNotUnique, ActiveRecord::NotNullViolation => e
    # prevent reattempts when a race condition attempts to write the same record
    # prevent reattempts when data is invalid
    Rollbar.error e
  end
end
