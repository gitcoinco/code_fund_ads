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

  def all_competitors_total_daily_budget
    @all_competitors_total_daily_budget ||= Money.new(all_competitors.sum(&:daily_budget), "USD")
  end

  def current_discrepancy
    average_daily_impressions_value - current_competitors_total_daily_budget
  end

  def total_discrepancy
    average_daily_impressions_value - all_competitors_total_daily_budget
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

  def unsold_daily_impressions_count(strategy: :rollup)
    return inventory_details.sum(&:unsold_daily_impressions_count) if strategy == :rollup
    return (total_discrepancy.to_f / average_individual_impression_value.to_f).floor if strategy == :caclulate
    0
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

  def average_individual_impression_value
    average_daily_impressions_value.to_f / average_daily_impressions_count
  end

  def inventory_details
    @inventory_details ||= campaign.targeting_variants.map { |(region, audience)|
      InventoryDetail.new(region, audience, ecpm_multiplier: campaign.ecpm_multiplier, start_date: campaign.start_date)
    }
  end

  def average_base_ecpm
    return Money.new(0) if inventory_details.blank?
    inventory_details.sum(&:base_ecpm) / inventory_details.size.to_f
  end

  def average_adjusted_ecpm
    return Money.new(0) if inventory_details.blank?
    inventory_details.sum(&:adjusted_ecpm) / inventory_details.size.to_f
  end

  def cache_key
    [
      "inventory_summary",
      campaign.daily_budget.cents,
      campaign.ecpm_multiplier,
      "regions",
      Digest::MD5.hexdigest(campaign.regions.map(&:id).join),
      "audiences",
      Digest::MD5.hexdigest(campaign.audiences.map(&:id).join),
      "all_competitors",
      Digest::MD5.hexdigest(all_competitors.map(&:id).join),
    ].join "/"
  end
end
