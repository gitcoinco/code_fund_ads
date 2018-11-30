# This job should be run as a failsafe... perhaps every 1-2 days
class SyncImpressionsCountersJob < ApplicationJob
  queue_as :counters_low

  def perform
    campaign_ids = Campaign.available.active.pluck(:id)
    property_ids = Property.active.pluck(:id)

    campaign_ids.each do |campaign_id|
      campaign = Campaign.find(campaign_id)
      property_ids.each do |property_id|
        property = Property.find(property_id)
        campaign.dates.each do |date|
          relation = Impression.on(date).where(campaign: campaign, property: property)
          if relation.exists?
            set_impression_count date, campaign, property, relation.count
            set_click_count date, campaign, property, relation.clicked.count
          end
        end
      end
    end
  end

  private

  def set_impression_count(date, campaign, property, count)
    update_counter ImpressionCounter.on(date).where(campaign: campaign, property: property), count
    Rails.cache.redis.del(
      campaign.total_impressions_count_cache_key,
      campaign.daily_impressions_count_cache_key(date)
    )
    # TODO: add property redis cache counters
  end

  def set_click_count(date, campaign, property, count)
    update_counter ClickCounter.on(date).where(campaign: campaign, property: property), count
    Rails.cache.redis.del(
      campaign.total_clicks_count_cache_key,
      campaign.daily_clicks_count_cache_key(date)
    )
    # TODO: add property redis cache counters
  end

  def update_counter(relation, count)
    if relation.exists?
      counter = relation.first
      counter.with_lock { counter.update_columns count: count }
    else
      relation.create! count: count
    end
  end
end
