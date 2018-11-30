# This job should be run as a failsafe... perhaps every 2-4 days
class SetClickCounterJob < ApplicationJob
  queue_as :counters_low

  def perform(campaign, date_string)
    date = Date.parse(date_string)
    campaign.property_ids_with_clicked_payable_impressions(date).each do |property_id|
      relation = Impression.clicked.payable.on(date).where(campaign: campaign, property_id: property_id)
      set_click_count date, campaign, property_id, relation.count
    end
  end

  private

  def set_click_count(date, campaign, property_id, count)
    update_counter ClickCounter.on(date).where(campaign: campaign, property_id: property_id), count
    Rails.cache.redis.del(
      campaign.total_clicks_count_cache_key,
      campaign.daily_clicks_count_cache_key(date)
    )
    # TODO: add property redis cache counters
  end

  def update_counter(counter_relation, count)
    return if count.zero?
    counter = counter_relation.first
    return counter_relation.create!(count: count) if counter.nil?
    counter.with_lock { counter.update_columns count: count }
  end
end
