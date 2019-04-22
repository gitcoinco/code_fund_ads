class EnsureDailySummariesJob < ApplicationJob
  queue_as :low

  def perform
    start_date = Date.current.beginning_of_month.advance(months: -2)
    end_date = Date.current.end_of_month

    Campaign.in_batches.each do |campaigns|
      campaigns.each do |campaign|
        CreateDailySummariesJob.perform_later campaign, start_date.iso8601, end_date.iso8601, nil
      end
    end

    Property.in_batches.each do |properties|
      properties.each do |property|
        CreateDailySummariesJob.perform_later property, start_date.iso8601, end_date.iso8601, nil
      end
    end
  end
end
