module CodeFundAds
  class Events
    def self.track(name, device_id, segmentation = {})
      return unless ENV["CODEFUND_ANALYTICS_KEY"].present?
      ActiveSupport::Notifications.instrument("track_event", data: {
        name: name,
        device_id: device_id,
        segmentation: segmentation,
      })
    end
  end
end

ActiveSupport::Notifications.subscribe "track_event" do |_name, _start, finish, _id, payload|
  data = payload[:data]
  TrackEventJob.perform_later(data[:name], finish.to_i, data[:device_id], data[:segmentation])
end
