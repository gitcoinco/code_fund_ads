class GlobalStatsController < ApplicationController
  def show
    imp_count = impression_count_query
    prop_count = properties_count_query
    camp_count = campaigns_count_query
    clicks = clicks_count_query
    click_rate = ((clicks / Impression.count.to_f) * 100).round 2

    render json: {impressions_count: imp_count,
                  properties_count: prop_count,
                  campaigns_count: camp_count,
                  click_rate: click_rate},
           status: :ok
  end

  private

  def impression_count_query
    Rails.cache.fetch "GlobalStats#impressions_count/#{Date.current.iso8601}", expires_in: 5.minute do
      ActiveRecord::Base.connected_to(role: :reading) do
        count = DailySummary.where(impressionable_type: "Property",
                                   scoped_by_type: nil,
                                   scoped_by_id: nil).sum(:impressions_count)

        count + Impression.on(Date.current).count
      end
    end
  end

  def properties_count_query
    Rails.cache.fetch "GlobalStats#properties_count/#{Date.current.iso8601}", expires_in: 24.hour do
      ActiveRecord::Base.connected_to(role: :reading) do
        Property.all.count
      end
    end
  end

  def campaigns_count_query
    Rails.cache.fetch "GlobalStats#campaigns_count/#{Date.current.iso8601}", expires_in: 24.hour do
      ActiveRecord::Base.connected_to(role: :reading) do
        Campaign.all.count
      end
    end
  end

  def clicks_count_query
    Rails.cache.fetch "GlobalStats#clicks_rate/#{Date.current.iso8601}", expires_in: 5.minute do
      ActiveRecord::Base.connected_to(role: :reading) do
        count = DailySummary.where(impressionable_type: "Property",
                                   scoped_by_type: nil,
                                   scoped_by_id: nil).sum(:clicks_count)
        count + Impression.on(Date.current).clicked.count
      end
    end
  end
end
