class InventorySummary
  attr_reader :campaign

  def initialize(campaign)
    @campaign = campaign
  end

  def current_competitors
    @current_competitors ||= campaign.current_premium_competitors.order(:start_date).to_a
  end

  def future_competitors
    @future_competitors ||= campaign.future_premium_competitors.order(:start_date).to_a
  end

  def all_competitors
    current_competitors + future_competitors
  end

  def current_competitors_total_daily_budget
    @current_competitors_total_daily_budget ||= Money.new(current_competitors.sum(&:daily_budget), "USD")
  end

  def future_competitors_total_daily_budget
    @future_competitors_total_daily_budget ||= Money.new(future_competitors.sum(&:daily_budget), "USD")
  end

  def average_daily_impressions_value
    @average_daily_impressions_value ||= inventory_details.sum(&:average_daily_impressions_value)
  end

  def average_daily_impressions_count
    @average_daily_impressions_count ||= inventory_details.sum(&:average_daily_impressions_count)
  end

  def sold_daily_impressions_count
    @sold_daily_impressions_count ||= inventory_details.sum(&:sold_daily_impressions_count)
  end

  def unsold_daily_impressions_count
    inventory_details.sum(&:unsold_daily_impressions_count)
  end

  def sold_daily_impressions_value
    @sold_daily_impressions_value ||= inventory_details.sum(&:sold_daily_impressions_value)
  end

  def unsold_daily_impressions_value
    @unsold_daily_impressions_value ||= inventory_details.sum(&:unsold_daily_impressions_value)
  end

  def available_daily_impressions_percentage
    @available_daily_impressions_percentage ||= if average_daily_impressions_count > 0
      unsold_daily_impressions_count / average_daily_impressions_count.to_f
    else
      0
    end
  end

  def estimated_impressions_count
    @estimated_impressions_count ||= inventory_details.sum(&:estimated_impressions_count)
  end

  def estimated_clicks_count
    @estimated_clicks_count ||= inventory_details.sum(&:estimated_clicks_count)
  end

  def estimated_cpm
    return Money.new(0) unless estimated_impressions_count > 0
    campaign.total_budget / (estimated_impressions_count / 1000.to_f)
  end

  def estimated_cpc
    return Money.new(0) unless estimated_clicks_count > 0
    campaign.total_budget / estimated_clicks_count
  end

  def inventory_details
    @inventory_details ||= campaign.targeting_variants.map { |(region, audience)|
      InventoryDetail.new self, region: region, audience: audience, ecpm_multiplier: campaign.ecpm_multiplier
    }
  end

  def average_base_ecpm
    return Money.new(0) if inventory_details.blank?
    inventory_details.sum(&:base_ecpm) / inventory_details.size.to_f
  end

  def average_click_rate
    @average_click_rate ||= begin
      countries = campaign.regions.map(&:countries).flatten
      [
        DailySummary.average_premium_click_rate_by_country(*countries),
        DailySummary.average_premium_click_rate_by_audience(*campaign.audiences),
        DailySummary.average_click_rate(countries: countries, audiences: campaign.audiences)
      ].sum / 3.to_f
    end
  end
end
