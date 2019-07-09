class EnsureScopedDailySummariesJob < ApplicationJob
  queue_as :low

  def perform
    start_date = 1.month.ago.beginning_of_month.to_date
    end_date = 1.day.ago.to_date

    Campaign.in_batches.each do |campaigns|
      campaigns.each do |campaign|
        next unless Impression.between(start_date, end_date).where(campaign: campaign).exists?

        country_codes = Impression.between(start_date, end_date).where(campaign: campaign).distinct.pluck(:country_code)
        country_codes.each do |country_code|
          CreateDailySummariesJob.perform_later campaign, start_date.iso8601, end_date.iso8601, country_code, "country_code"
        end

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

        country_codes = Impression.between(start_date, end_date).where(property: property).distinct.pluck(:country_code)
        country_codes.each do |country_code|
          CreateDailySummariesJob.perform_later property, start_date.iso8601, end_date.iso8601, country_code, "country_code"
        end

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
