class InventoryDetail
  attr_reader :region, :audience, :start_date, :end_date, :ecpm_multiplier

  def initialize(region, audience, start_date:, end_date: nil, ecpm_multiplier: 1)
    @region = region
    @audience = audience
    @start_date = start_date
    @end_date = end_date
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

  def sold_impressions_count
    (sold_budget_total.to_f / individual_impression_value).floor
  end

  def unsold_impressions_count
    (unsold_budget_total.to_f / individual_impression_value).floor
  end

  def impressions_value
    (impressions_count / 1000.to_f) * base_ecpm
  end

  def individual_impression_value
    base_ecpm.to_f / 1000
  end

  def sold_budget_total
    @sold_budget_total ||= begin
      relation = Campaign.active.with_any_country_codes(*region.country_codes).with_any_keywords(*audience.keywords).available_on(start_date)
      relation = relation.unending.or(relation.ends_on_or_before(end_date)) if end_date
      Money.new relation.sum(:daily_budget_cents), "USD"
    end
  end

  def unsold_budget_total
    impressions_value - sold_budget_total
  end
end
