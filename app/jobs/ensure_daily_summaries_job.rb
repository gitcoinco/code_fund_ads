class EnsureDailySummariesJob < ApplicationJob
  queue_as :low

  def perform
    dates = [
      Date.current.beginning_of_month,
      Date.current.beginning_of_month.advance(months: -1),
      Date.current.beginning_of_month.advance(months: -2),
    ]

    Campaign.active.each do |campaign|
      dates.each do |date|
        campaign.daily_impressions_counts(date, date.end_of_month)
      end
    end

    Property.active.each do |property|
      dates.each do |date|
        property.daily_impressions_counts(date, date.end_of_month)
      end
    end
  end
end
