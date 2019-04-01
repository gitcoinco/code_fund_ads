class EnsureDailySummariesJob < ApplicationJob
  queue_as :low

  def perform
    dates = [
      Date.current.beginning_of_month.advance(months: -2),
      Date.current.beginning_of_month.advance(months: -1),
      Date.current.beginning_of_month,
    ]

    Campaign.in_batches.each do |campaigns|
      campaigns.each do |campaign|
        dates.each do |date|
          next unless campaign.available_on?(date)
          campaign.daily_impressions_counts(date, date.end_of_month, fresh: true)
        end
      end
    end

    Property.in_batches.each do |properties|
      properties.each do |property|
        dates.each do |date|
          property.daily_impressions_counts(date, date.end_of_month, fresh: true)
        end
      end
    end
  end
end
