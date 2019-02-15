module Properties
  module Predictable
    extend ActiveSupport::Concern

    def estimated_gross_revenue(start_date, end_date)
      Money.new(impressions.between(start_date, end_date).sum(:estimated_gross_revenue_fractional_cents).round, "USD")
    end

    def estimated_property_revenue(start_date, end_date)
      estimated_gross_revenue(start_date, end_date) * revenue_percentage
    end

    def estimated_house_revenue(start_date, end_date)
      estimated_gross_revenue(start_date, end_date) - estimated_house_revenue(start_date, end_date)
    end

    def estimated_campaign_gross_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      Money.new(impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_gross_revenue_fractional_cents).round, "USD")
    end

    def estimated_campaign_property_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      Money.new(impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_property_revenue_fractional_cents).round, "USD")
    end

    def estimated_campaign_house_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      Money.new(impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_house_revenue_fractional_cents).round, "USD")
    end
  end
end
