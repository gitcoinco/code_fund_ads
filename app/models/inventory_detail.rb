class InventoryDetail
  attr_reader :region, :audience

  def initialize(region, audience)
    @region = region
    @audience = audience
  end

  def ecpm
    @ecmp ||= region.ecpm(audience)
  end

  def impressions_count
    @impressions_count ||= Country.average_daily_impressions_count(countries: region.countries, audience: audience)
  end

  def impressions_value
    (impressions_count / 1000.to_f) * ecpm
  end
end
