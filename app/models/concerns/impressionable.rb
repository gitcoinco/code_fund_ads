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
      date = Date.parse((date || Date.current).to_s).to_date
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
      date = Date.parse((date || Date.current).to_s).to_date
      subquery = Impression.clicked.select("COUNT(*)").
        where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
        where(Impression.arel_table[:displayed_at_date].eq(date))
      select(arel_table[Arel.star]).select(subquery.arel.as(DAILY_CLICKS_COUNT_KEY))
    }

    scope :include_daily_click_rate, ->(date = nil) {
      date = Date.parse((date || Date.current).to_s).to_date
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

  def daily_impressions_count_cache_key(date = nil)
    "#{cache_key}/#{DAILY_IMPRESSIONS_COUNT_KEY}/#{(date || Date.current).to_date.iso8601}"
  end

  def total_impressions_count
    Rails.cache.fetch total_impressions_count_cache_key do
      impressions.count
    end
  end

  def total_impressions_per_mille
    total_impressions_count.to_i / 1_000.to_f
  end

  def daily_impressions_count(date = nil)
    date = Date.parse((date || Date.current).to_s).to_date
    Rails.cache.fetch daily_impressions_count_cache_key(date) do
      impressions.on(date).count
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
    result = relation.first
    return [] unless result.min
    (result.min..result.max).to_a
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

  def daily_clicks_count_cache_key(date = nil)
    "#{cache_key}/#{DAILY_CLICKS_COUNT_KEY}/#{(date || Date.current).to_date.iso8601}"
  end

  def total_clicks_count
    Rails.cache.fetch total_clicks_count_cache_key do
      impressions.clicked.count
    end
  end

  def daily_clicks_count(date = nil)
    date = Date.parse(date || Date.current).to_date
    Rails.cache.fetch daily_clicks_count_cache_key(date) do
      impressions.on(date).clicked.count
    end
  end

  def total_click_rate
    return 0 if total_impressions_count.zero?
    (total_clicks_count / total_impressions_count.to_f) * 100
  end

  def daily_click_rate(date = nil)
    date ||= Date.current
    impressions_count = daily_impressions_count(date)
    clicks_count = daily_clicks_count(date)
    return 0 if impressions_count.zero?
    (clicks_count / impressions_count.to_f) * 100
  end
end
