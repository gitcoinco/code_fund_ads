class TrackEventJob < ApplicationJob
  queue_as :low

  def perform(name, timestamp, ip_address, segmentation = {}, device_id = SecureRandom.uuid)
    Typhoeus.post("https://analytics.codefund.app/i",
      body: {
        events: [
          {
            key: name,
            count: 1,
            sum: 0,
            timestamp: timestamp,
            segmentation: {ip_address: ip_address}.merge(segmentation),
          },
        ],
      }.to_json,
      params: {app_key: ENV["CODEFUND_ANALYTICS_KEY"], device_id: device_id},
      headers: {"Content-Type" => "application/json"})
  end
end
