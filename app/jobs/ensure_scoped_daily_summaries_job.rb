class EnsureScopedDailySummariesJob < ApplicationJob
  queue_as :low

  def perform
    start_date = 7.days.ago.to_date
    end_date = 1.day.ago.to_date

    Campaign.in_batches.each do |campaigns|
      campaigns.each do |campaign|
        next unless Impression.between(start_date, end_date).where(campaign: campaign).exists?
        Property.in_batches.each do |properties|
          properties.each do |property|
            next unless Impression.between(start_date..end_date).where(campaign: campaign, property: property).exists?
            CreateDailySummariesJob.perform_later campaign, start_date.iso8601, end_date.iso8601, property
          end
        end
      end
    end

    Property.in_batches.each do |properties|
      properties.each do |property|
        next unless Impression.between(start_date, end_date).where(property: property).exists?
        Campaign.in_batches.each do |campaigns|
          campaigns.each do |campaign|
            next unless Impression.between(start_date..end_date).where(property: property, campaign: campaign).exists?
            CreateDailySummariesJob.perform_later property, start_date.iso8601, end_date.iso8601, campaign
          end
        end
      end
    end
  end
end
