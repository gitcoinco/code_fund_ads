class TrackEventJob < ApplicationJob
  queue_as :low

  def perform(name, timestamp, device_id, segmentation = {})
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    Typhoeus.post("https://analytics.codefund.app/i",
      body: {
        events: [
          {
            key: name,
            count: 1,
            sum: 0,
            timestamp: timestamp,
            segmentation: segmentation,
          },
        ],
      }.to_json,
      params: {app_key: ENV["CODEFUND_ANALYTICS_KEY"], device_id: device_id},
      headers: {"Content-Type" => "application/json"})
  end
end
