class DailyRevenueCalculator
  attr_reader :property, :campaign, :start_date, :end_date

  def initialize(start_date, end_date, property, campaign)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
    @property = property
    @campaign = campaign
  end

  def ecpm(date)
    @ecpms ||= {}
    @ecpms[date] ||= campaign.applicable_ecpm_on(date)
  end

  def impression_count
    @impression_count ||= property.impressions.
      partitioned(campaign.user, start_date, end_date).
      where(campaign: campaign).
      group(:displayed_at_date).
      count
  end

  def impressions_per_mille(date)
    (impression_count[date] || 0) / 1_000.to_f
  end

  def gross_revenue
    @gross_revenue ||= (start_date..end_date).sum { |date| ecpm(date) * impressions_per_mille(date) }
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
