module Properties
  module Predictable
    extend ActiveSupport::Concern

    def estimated_gross_revenue(start_date = nil, end_date = nil)
      relation = impressions
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_gross_revenue_fractional_cents)
      Money.new cents, "USD"
    end

    def estimated_property_revenue(start_date = nil, end_date = nil)
      relation = impressions
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_property_revenue_fractional_cents)
      Money.new cents, "USD"
    end

    def estimated_house_revenue(start_date = nil, end_date = nil)
      relation = impressions
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_house_revenue_fractional_cents)
      Money.new cents, "USD"
    end

    def estimated_campaign_gross_revenue(campaign, start_date = nil, end_date = nil)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      relation = impressions.where(campaign_id: campaign_id)
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_gross_revenue_fractional_cents)
      Money.new cents, "USD"
    end

    def estimated_campaign_property_revenue(campaign, start_date = nil, end_date = nil)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      relation = impressions.where(campaign_id: campaign_id)
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_property_revenue_fractional_cents)
      Money.new cents, "USD"
    end

    def estimated_campaign_house_revenue(campaign, start_date = nil, end_date = nil)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      relation = impressions.where(campaign_id: campaign_id)
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_house_revenue_fractional_cents)
      Money.new cents, "USD"
    end
  end
end
