case Rails.env
when "production"
  StatsD.backend = StatsD::Instrument::Backends::UDPBackend.new("#{ENV["STATSD_HOST"]}:#{ENV["STATSD_PORT"]}", :statsd)
  StatsD.prefix = ENV["STATSD_PREFIX"]
when "development"
  StatsD.backend = StatsD::Instrument::Backends::LoggerBackend.new(Rails.logger)
end

def statsd_increment(key)
  return unless key.present?
  StatsD.increment key
rescue StandardError => e
  Rails.logger.error "StatsD increment failed! #{e.message}"
end

ActiveSupport::Notifications.subscribe "increment.statsd" do |_name, _started, _finished, _unique_id, data|
  statsd_increment data[:key]
end
