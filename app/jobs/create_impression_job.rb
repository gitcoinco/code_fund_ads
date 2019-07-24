class CreateImpressionJob < ApplicationJob
  queue_as :impression

  def perform(id, campaign_id, property_id, creative_id, ad_template, ad_theme, ip_address, user_agent, displayed_at_string)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    @event_id = SecureRandom.uuid
    @ip_address = ip_address

    campaign = Campaign.find_by(id: campaign_id)
    property = Property.find_by(id: property_id)

    return unless campaign && property

    displayed_at = Time.parse(displayed_at_string)
    ip_info = MMDB.lookup(ip_address)
    country_code = Country.find(ip_info&.country&.iso_code)&.iso_code
    subdivision = ip_info&.subdivisions&.first&.iso_code
    province_code = Province.find("#{country_code}-#{subdivision}")&.iso_code

    ip_address_salt = ENV.fetch("IP_ADDRESS_SALT") {
      "038fd0b1517a30d340838541afc0d3cea2899aa67969346d4c0d17d64644de1183033005fcceb149da61a3454f43b7a1c8cbbad4c6953117aa2f0e2a4efb42b9"
    }

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
      ip_address: Digest::MD5.hexdigest("#{ip_address}#{ip_address_salt}"),
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
