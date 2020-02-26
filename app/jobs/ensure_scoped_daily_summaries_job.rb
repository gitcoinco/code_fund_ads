class EnsureScopedDailySummariesJob < ApplicationJob
  queue_as :ensure_scoped_daily_summaries

  def perform(start_date = nil, end_date = nil)
    start_date = Date.coerce(start_date || 7.days.ago.to_date)
    end_date = Date.coerce(end_date || 1.day.ago.to_date)
    ensure_daily_summaries_for_campaigns start_date, end_date
    ensure_daily_summaries_for_properties start_date, end_date
  end

  private

  def ensure_daily_summaries_for_campaigns(start_date, end_date)
    Campaign.available_on(start_date).or(Campaign.available_on(end_date)).in_batches.each do |campaigns|
      campaigns.each do |campaign|
        impressions = campaign.impressions.between(start_date, end_date)
        next unless impressions.exists?

        country_codes = impressions.distinct.pluck(:country_code)
        country_codes.each do |country_code|
          CreateDailySummariesJob.perform_later campaign, start_date.iso8601, end_date.iso8601, country_code, "country_code"
        end

        Property.where(id: impressions.distinct.select(:property_id)).in_batches.each do |properties|
          properties.each do |property|
            CreateDailySummariesJob.perform_later campaign, start_date.iso8601, end_date.iso8601, property
          end
        end

        Creative.where(id: impressions.distinct.select(:creative_id)).in_batches.each do |creatives|
          creatives.each do |creative|
            CreateDailySummariesJob.perform_later campaign, start_date.iso8601, end_date.iso8601, creative
          end
        end
      end
    end
  end

  def ensure_daily_summaries_for_properties(start_date, end_date)
    Property.active.in_batches.each do |properties|
      properties.each do |property|
        impressions = property.impressions.between(start_date, end_date)
        next unless impressions.exists?

        country_codes = impressions.distinct.pluck(:country_code)
        country_codes.each do |country_code|
          CreateDailySummariesJob.perform_later property, start_date.iso8601, end_date.iso8601, country_code, "country_code"
        end

        Campaign.where(id: impressions.distinct.select(:campaign_id)).in_batches.each do |campaigns|
          campaigns.each do |campaign|
            CreateDailySummariesJob.perform_later property, start_date.iso8601, end_date.iso8601, campaign
          end
        end
      end
    end
  end
end
