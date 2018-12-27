module Impressionable
  extend ActiveSupport::Concern

  TOTAL_IMPRESSIONS_COUNT_KEY = "total_impressions_count".freeze
  DAILY_IMPRESSIONS_COUNT_KEY = "daily_impressions_count".freeze
  TOTAL_CLICKS_COUNT_KEY = "total_clicks_count".freeze
  DAILY_CLICKS_COUNT_KEY = "daily_clicks_count".freeze

  included do
    scope :include_total_impressions_count, -> {
      subquery = Impression.select("COUNT(*)").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].gteq(Campaign.arel_table[:start_date])).
        where(Impression.arel_table[:displayed_at_date].lteq(Campaign.arel_table[:end_date]))
      select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_IMPRESSIONS_COUNT_KEY))
    }

    scope :include_daily_impressions_count, ->(date = nil) {
      date = Date.coerce(date)
      subquery = Impression.select("COUNT(*)").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].eq(date))
      select(arel_table[Arel.star]).select(subquery.arel.as(DAILY_IMPRESSIONS_COUNT_KEY))
    }

    scope :include_total_clicks_count, -> {
      subquery = Impression.clicked.select("COUNT(*)").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].gteq(Campaign.arel_table[:start_date])).
        where(Impression.arel_table[:displayed_at_date].lteq(Campaign.arel_table[:end_date]))
      select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_CLICKS_COUNT_KEY))
    }

    scope :include_total_click_rate, -> {
      impression_count_subquery = Impression.select("COUNT(*)::numeric").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].gteq(Campaign.arel_table[:start_date])).
        where(Impression.arel_table[:displayed_at_date].lteq(Campaign.arel_table[:end_date]))
      click_count_subquery = impression_count_subquery.clicked
      divide = Arel::Nodes::Division.new(click_count_subquery.arel, impression_count_subquery.arel)
      select(arel_table[Arel.star]).select(divide.as("total_click_rate"))
    }

    scope :include_daily_clicks_count, ->(date = nil) {
      date = Date.coerce(date)
      subquery = Impression.clicked.select("COUNT(*)").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].eq(date))
      select(arel_table[Arel.star]).select(subquery.arel.as(DAILY_CLICKS_COUNT_KEY))
    }

    scope :include_daily_click_rate, ->(date = nil) {
      date = Date.coerce(date)
      impression_count_subquery = Impression.select("COUNT(*)::numeric").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].eq(date))
      click_count_subquery = impression_count_subquery.clicked
      divide = Arel::Nodes::Division.new(click_count_subquery.arel, impression_count_subquery.arel)
      select(arel_table[Arel.star]).select(divide.as("daily_click_rate"))
    }
  end

  def total_impressions_count_cache_key
    "#{cache_key}/#{TOTAL_IMPRESSIONS_COUNT_KEY}"
  end

  def total_impressions_count
    Rails.cache.fetch(total_impressions_count_cache_key) { impressions.count }.to_i
  end

  def total_impressions_per_mille
    total_impressions_count.to_i / 1_000.to_f
  end

  def daily_impressions_count_cache_key(date)
    "#{cache_key}/#{DAILY_IMPRESSIONS_COUNT_KEY}/#{date.iso8601}"
  end

  def daily_impressions_count(date = nil)
    date = Date.coerce(date)
    Rails.cache.fetch(daily_impressions_count_cache_key(date)) { impressions.on(date).count }.to_i
  end

  def daily_impressions_counts(start_date = nil, end_date = nil)
    key = "#{cache_key}/#{__method__}/#{Date.cache_key(start_date, coerce: false)}-#{Date.cache_key(end_date, coerce: false)}"
    Rails.cache.fetch key do
      probable_dates_with_impressions(start_date, end_date).map do |date|
        daily_impressions_count date
      end
    end
  end

  def daily_impressions_per_mille(date = nil)
    daily_impressions_count(date).to_i / 1_000.to_f
  end

  # Returns an Array of probable dates with impressions
  #
  # No dates are missed; however, there may be false positives
  # i.e. dates returned that don't actually have impressions
  #
  # NOTE: This method outperforms #dates_with_impressions
  def probable_dates_with_impressions(start_date = nil, end_date = nil)
    relation = impressions.
      select(Impression.arel_table[:displayed_at_date].minimum.as("min")).
      select(Impression.arel_table[:displayed_at_date].maximum.as("max")).
      limit(1)
    relation = relation.between(start_date, end_date) if start_date && end_date
    relation = relation.on(start_date) if start_date && end_date.nil?
    result = self.class.connection.execute(relation.to_sql).first
    return [] unless result["min"]
    min = Date.coerce(result["min"])
    max = Date.coerce(result["max"])
    (min..max).to_a
  end

  def dates_with_impressions(start_date = nil, end_date = nil)
    return impressions.between(start_date, end_date).distinct(:displayed_at_date).pluck(:displayed_at_date) if start_date
    impressions.distinct(:displayed_at_date).pluck(:displayed_at_date)
  end

  def dates_with_clicked_impressions(start_date = nil, end_date = nil)
    return impressions.clicked.between(start_date, end_date).distinct(:displayed_at_date).pluck(:displayed_at_date) if start_date
    impressions.clicked.distinct(:displayed_at_date).pluck(:displayed_at_date)
  end

  def total_clicks_count_cache_key
    "#{cache_key}/#{TOTAL_CLICKS_COUNT_KEY}"
  end

  def total_clicks_count
    Rails.cache.fetch(total_clicks_count_cache_key) { impressions.clicked.count }
  end

  def daily_clicks_count_cache_key(date)
    "#{cache_key}/#{DAILY_CLICKS_COUNT_KEY}/#{date.iso8601}"
  end

  def daily_clicks_count(date = nil)
    date = Date.coerce(date)
    Rails.cache.fetch(daily_clicks_count_cache_key(date)) { impressions.on(date).clicked.count }.to_i
  end

  def daily_clicks_counts(start_date = nil, end_date = nil)
    key = "#{cache_key}/#{__method__}/#{Date.cache_key(start_date, coerce: false)}-#{Date.cache_key(end_date, coerce: false)}"
    Rails.cache.fetch(key) {
      probable_dates_with_impressions(start_date, end_date).map do |date|
        daily_clicks_count date
      end
    }
  end

  def total_click_rate
    return 0 if total_impressions_count.zero?
    (total_clicks_count / total_impressions_count.to_f) * 100
  end

  def daily_click_rate(date = nil)
    date = Date.coerce(date)
    impressions_count = daily_impressions_count(date)
    clicks_count = daily_clicks_count(date)
    return 0 if impressions_count.zero?
    (clicks_count / impressions_count.to_f) * 100
  end

  def daily_click_rates(start_date = nil, end_date = nil)
    icounts = daily_impressions_counts(start_date, end_date)
    ccounts = daily_clicks_counts(start_date, end_date)
    icounts.map.with_index do |icount, i|
      icount > 0 ? (ccounts[i] / icount.to_f) * 100 : 0
    end
  end

  def click_rate(start_date = nil, end_date = nil)
    impressions = daily_impressions_counts(start_date, end_date).sum
    return 0 if impressions.zero?
    clicks = daily_clicks_counts(start_date, end_date).sum
    (clicks / impressions.to_f) * 100
  end
end
