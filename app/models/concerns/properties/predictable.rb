module Properties
  module Predictable
    extend ActiveSupport::Concern

    def estimated_gross_revenue(start_date, end_date)
      key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.between(start_date, end_date).sum(:estimated_gross_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end

    def estimated_property_revenue(start_date, end_date)
      key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.between(start_date, end_date).sum(:estimated_property_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end

    def estimated_house_revenue(start_date, end_date)
      key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.between(start_date, end_date).sum(:estimated_house_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end

    def estimated_campaign_gross_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      key = "#{cache_key}/#{__method__}/#{campaign_id}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_gross_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end

    def estimated_campaign_property_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      key = "#{cache_key}/#{__method__}/#{campaign_id}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_property_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end

    def estimated_campaign_house_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      key = "#{cache_key}/#{__method__}/#{campaign_id}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_house_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end
  end
end
