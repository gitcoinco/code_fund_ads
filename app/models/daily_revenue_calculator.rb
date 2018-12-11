class DailyRevenueCalculator
  attr_reader :property, :campaign, :date

  def initialize(date, property, campaign)
    @date = date
    @property = property
    @campaign = campaign
  end

  def ecpm
    @ecpm ||= campaign.applicable_ecpm_on(date)
  end

  def impression_count
    @impression_count ||= property.impressions.partitioned(campaign.user, date, date).count
  end

  def impressions_per_mille
    @impressions_per_mille ||= impression_count / 1_000.to_f
  end

  def gross_revenue
    @gross_revenue ||= ecpm * impressions_per_mille
  end

  def property_revenue
    @property_revenue ||= gross_revenue * property.revenue_percentage
  end

  def house_revenue
    @house_revenue ||= gross_revenue - property_revenue
  end

  def present?
    gross_revenue > 0
  end
end
