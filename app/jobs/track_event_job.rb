class TrackEventJob < ApplicationJob
  queue_as :low

  def perform(name, timestamp, segmentation={}, devise_id=SecureRandom.uuid)
    url = "https://analytics.codefund.app/i"
    body = {
      timestamp: timestamp,
      events: [{
        key: name,
        count: 1,
        sum: 0,
        segmentation: segmentation
      }]
    }
    params = { app_key: ENV["CODEFUND_ANALYTICS_KEY"], device_id: devise_id }
    headers = {"Content-Type" => "application/json"}
    
    Typhoeus.post(
      url,
      body: body,
      params: params,
      headers: headers
    )
  end
end
