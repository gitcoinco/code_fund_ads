class InventoryDetail
  attr_reader :inventory_summary, :campaign, :region, :audience, :ecpm_multiplier
  delegate :start_date, :end_date, to: :campaign

  def initialize(inventory_summary, region:, audience:, ecpm_multiplier: 1)
    @inventory_summary = inventory_summary
    @campaign = inventory_summary.campaign
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

  def average_daily_impressions_count
    @average_daily_impressions_count ||= Country.average_daily_impressions_count(countries: region.countries, audience: audience)
  end

  # Returns the estimated percentage of total impressions that this region/audiece targeting will produce for the campaign
  def percentage
    return 0 if inventory_summary.average_daily_impressions_count == 0
    average_daily_impressions_count / inventory_summary.average_daily_impressions_count.to_f
  end

  def applicable_total_budget
    campaign.total_budget * percentage
  end

  def applicable_daily_budget
    applicable_total_budget / campaign.total_operative_days
  end

  def estimated_impressions_count
    (applicable_total_budget / individual_impression_adjusted_value).to_f.round
  end

  def estimated_clicks_count
    (estimated_impressions_count * (average_click_rate / 100)).round
  end

  def estimated_cpc
    return Money.new(0) unless estimated_clicks_count > 0
    applicable_total_budget / estimated_clicks_count
  end

  def sold_daily_impressions_count
    (sold_daily_impressions_value.to_f / individual_impression_base_value).floor
  end

  def unsold_daily_impressions_count
    (unsold_daily_impressions_value.to_f / individual_impression_base_value).floor
  end

  def average_daily_impressions_value
    (average_daily_impressions_count / 1000.to_f) * base_ecpm
  end

  def individual_impression_base_value
    base_ecpm.to_f / 1000
  end

  def individual_impression_adjusted_value
    adjusted_ecpm.to_f / 1000
  end

  def sold_daily_impressions_value
    @sold_daily_impressions_value ||= begin
      campaigns = Campaign.active.or(Campaign.accepted).premium.with_any_country_codes(*region.country_codes).with_any_keywords(*audience.keywords).available_on(start_date)
      campaigns = campaigns.unending.or(campaigns.ends_on_or_before(end_date)) if end_date
      sold_inventory_details = campaigns.each_with_object([]) { |c, memo|
        match = c.inventory_summary.inventory_details.find { |inventory_detail|
          inventory_detail.region == region && inventory_detail.audience == audience
        }
        memo << match if match
      }
      adjusted_daily_budgets = sold_inventory_details.map { |inventory_detail|
        inventory_detail.campaign.daily_budget * inventory_detail.percentage
      }
      Money.new adjusted_daily_budgets.sum, "USD"
    end
  end

  def unsold_daily_impressions_value
    average_daily_impressions_value - sold_daily_impressions_value
  end

  def average_click_rate
    @average_click_rate ||= begin
      [
        DailySummary.average_premium_click_rate_by_country(*region.countries),
        DailySummary.average_premium_click_rate_by_audience(audience),
        DailySummary.average_click_rate(countries: region.countries, audiences: [audience])
      ].sum / 3.to_f
    end
  end
end
