class InventoryDetail
  attr_reader :region, :audience, :ecpm_multiplier

  def initialize(region, audience, ecpm_multiplier: 1)
    @region = region
    @audience = audience
    @ecpm_multiplier = ecpm_multiplier
  end

  def base_ecpm
    @base_ecpm ||= region.ecpm(audience)
  end

  def adjusted_ecpm
    base_ecpm * ecpm_multiplier
  end

  def impressions_count
    @impressions_count ||= Country.average_daily_impressions_count(countries: region.countries, audience: audience)
  end

  def impressions_value
    (impressions_count / 1000.to_f) * base_ecpm
  end
end
