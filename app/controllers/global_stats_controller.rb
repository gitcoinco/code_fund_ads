class GlobalStatsController < ApplicationController
  def show
    count = impression_count_query
    clicks = clicks_count_query
    rate = ((clicks / Impression.count.to_f) * 100).round 2

    render json: {impressions_total_count: count,
                  impressions_click_count: clicks,
                  impressions_click_rate: rate,},
           status: :ok
  end

  private

  def impression_count_query
    Rails.cache.fetch "ImpressionStats#impressions_count/#{Date.current.iso8601}", expires_in: 5.minute do
      ActiveRecord::Base.connected_to(role: :reading) do
        count = DailySummary.where(impressionable_type: "Property",
                                   scoped_by_type: nil,
                                   scoped_by_id: nil).sum(:impressions_count)

        count + Impression.on(Date.current).count
      end
    end
  end

  def clicks_count_query
    Rails.cache.fetch "ImpressionStats#clicks_count/#{Date.current.iso8601}", expires_in: 5.minute do
      ActiveRecord::Base.connected_to(role: :reading) do
        count = DailySummary.where(impressionable_type: "Property",
                                   scoped_by_type: nil,
                                   scoped_by_id: nil).sum(:clicks_count)
        count + Impression.on(Date.current).clicked.count
      end
    end
  end
end
