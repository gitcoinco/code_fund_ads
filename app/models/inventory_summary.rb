class InventorySummary
  attr_reader :campaign

  def initialize(campaign)
    @campaign = campaign
  end

  def competitors
    @competitors ||= campaign.premium_competitors.order(:start_date).to_a
  end

  def competitors_total_daily_budget
    @competitors_total_daily_budget ||= Money.new(competitors.sum(&:daily_budget), "USD")
  end

  def average_daily_inventory_value
    @average_daily_inventory_value ||= inventory_details.sum(&:impressions_value)
  end

  def average_daily_impressions_count
    @average_daily_impressions_count ||= inventory_details.sum(&:impressions_count)
  end

  def available_daily_inventory_value
    @available_daily_inventory_value ||= average_daily_inventory_value - competitors_total_daily_budget
  end

  def available_daily_inventory_percentage
    @available_daily_inventory_percentage ||= if average_daily_inventory_value > 0
      available_daily_inventory_value / average_daily_inventory_value.to_f
    else
      0
    end
  end

  def avaliable_daily_impressions_count
    @avaliable_daily_impressions_count ||= if available_daily_inventory_percentage > 0
      (average_daily_impressions_count / available_daily_inventory_percentage.to_f).floor
    else
      0
    end
  end

  def inventory_details
    @inventory_details ||= campaign.targeting_variants.map { |(region, audience)|
      InventoryDetail.new(region, audience)
    }
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
      "competitors",
      Digest::MD5.hexdigest(competitors.map(&:id).join),
    ].join "/"
  end
end
