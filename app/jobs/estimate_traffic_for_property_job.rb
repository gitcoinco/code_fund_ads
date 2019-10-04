class EstimateTrafficForPropertyJob < ApplicationJob
  queue_as :traffic

  def perform(property_id)
    property = Property.find(property_id)
    data = TrafficEstimator.lookup(property.url)[:data]
    return if data.blank?
    estimate = PropertyTrafficEstimate.new
    estimate.property_id = property_id
    estimate.site_worth = Money.new(str_to_number(data.dig(:estimations, :site_worth)) * 100)
    estimate.visitors_daily = str_to_number(data.dig(:estimations, :visitors, :daily))
    estimate.visitors_monthly = str_to_number(data.dig(:estimations, :visitors, :monthly))
    estimate.visitors_yearly = str_to_number(data.dig(:estimations, :visitors, :yearly))
    estimate.pageviews_daily = str_to_number(data.dig(:estimations, :pageviews, :daily))
    estimate.pageviews_monthly = str_to_number(data.dig(:estimations, :pageviews, :monthly))
    estimate.pageviews_yearly = str_to_number(data.dig(:estimations, :pageviews, :yearly))
    estimate.revenue_daily = Money.new(str_to_number(data.dig(:estimations, :revenue, :daily)) * 100)
    estimate.revenue_monthly = Money.new(str_to_number(data.dig(:estimations, :revenue, :monthly)) * 100)
    estimate.revenue_yearly = Money.new(str_to_number(data.dig(:estimations, :revenue, :yearly)) * 100)
    estimate.alexa_rank_3_months = str_to_number(data.dig(:alexa, :rank, :"3_months"))
    estimate.alexa_rank_1_month = str_to_number(data.dig(:alexa, :rank, :"1_month"))
    estimate.alexa_rank_7_days = str_to_number(data.dig(:alexa, :rank, :"7_days"))
    estimate.alexa_rank_1_day = str_to_number(data.dig(:alexa, :rank, :"1_day"))
    estimate.alexa_rank_delta_3_months = str_to_number(data.dig(:alexa, :rank_delta, :"3_months"))
    estimate.alexa_rank_delta_1_month = str_to_number(data.dig(:alexa, :rank_delta, :"1_month"))
    estimate.alexa_rank_delta_7_days = str_to_number(data.dig(:alexa, :rank_delta, :"7_days"))
    estimate.alexa_rank_delta_1_day = str_to_number(data.dig(:alexa, :rank_delta, :"1_day"))
    estimate.alexa_reach_3_months = str_to_number(data.dig(:alexa, :reach, :"3_months"))
    estimate.alexa_reach_1_month = str_to_number(data.dig(:alexa, :reach, :"1_month"))
    estimate.alexa_reach_7_days = str_to_number(data.dig(:alexa, :reach, :"7_days"))
    estimate.alexa_reach_1_day = str_to_number(data.dig(:alexa, :reach, :"1_day"))
    estimate.alexa_reach_delta_3_months = str_to_number(data.dig(:alexa, :reach_delta, :"3_months"))
    estimate.alexa_reach_delta_1_month = str_to_number(data.dig(:alexa, :reach_delta, :"1_month"))
    estimate.alexa_reach_delta_7_days = str_to_number(data.dig(:alexa, :reach_delta, :"7_days"))
    estimate.alexa_reach_delta_1_day = str_to_number(data.dig(:alexa, :reach_delta, :"1_day"))
    estimate.alexa_pageviews_3_months = str_to_number(data.dig(:alexa, :pageviews, :"3_months"))
    estimate.alexa_pageviews_1_month = str_to_number(data.dig(:alexa, :pageviews, :"1_month"))
    estimate.alexa_pageviews_7_days = str_to_number(data.dig(:alexa, :pageviews, :"7_days"))
    estimate.alexa_pageviews_1_day = str_to_number(data.dig(:alexa, :pageviews, :"1_day"))
    estimate.alexa_pageviews_delta_3_months = percent_to_float(str_to_number(data.dig(:alexa, :pageviews_delta, :"3_months")))
    estimate.alexa_pageviews_delta_1_month = percent_to_float(str_to_number(data.dig(:alexa, :pageviews_delta, :"1_month")))
    estimate.alexa_pageviews_delta_7_days = percent_to_float(str_to_number(data.dig(:alexa, :pageviews_delta, :"7_days")))
    estimate.alexa_pageviews_delta_1_day = percent_to_float(str_to_number(data.dig(:alexa, :pageviews_delta, :"1_day")))
    estimate.save!
  rescue => e
    Rollbar.error e
  end

  def str_to_number(str)
    str.to_s.scan(/\-?\d{0,}+\.?\d{0,}/).join.to_f
  end

  private

  def percent_to_float(pct)
    pct * 0.01
  end
end
