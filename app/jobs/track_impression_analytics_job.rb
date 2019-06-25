class TrackImpressionAnalyticsJob < ApplicationJob
  class << self
    def property_ids
      ENV["ANALYTICS_PROPERTY_IDS"].to_s.split(",").select(&:present?)
    end

    def property_id(property_analytics_key)
      property_analytics_key.to_s.split(":").first.to_i
    end

    def track_property?(property_analytics_key)
      property_ids.include? property_id(property_analytics_key).to_s
    end
  end

  def perform(impression_id, event_name, options = {})
    return unless impression_id && event_name
    return unless TrackImpressionAnalyticsJob.track_property?(options["property_key"])

    tracker = Staccato.tracker(ENV["GOOGLE_ANALYTICS_TRACKING_ID"], impression_id)
    event = tracker.build_event(
      category: "Impression",
      action: event_name,
      label: options["property_key"]
    )
    event.add_custom_dimension 1, options["campaign_key"]
    event.add_custom_dimension 2, options["creative_key"]
    event.add_custom_dimension 3, options["ad_template"]
    event.add_custom_dimension 4, options["ad_theme"]
    event.add_custom_dimension 5, options["country_code"]
    event.add_custom_metric 1, options["gross_revenue"].to_f
    event.track!
  rescue => e
    Rollbar.error e
  end
end
