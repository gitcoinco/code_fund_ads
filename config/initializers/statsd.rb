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
end

events = %w[
  create_impression_job_fail.codefund
  create_impression_job_success.codefund
  create_virtual_impression.codefund
  find_virtual_impression.codefund
  render_legacy_ad.codefund
]

events.each do |event|
  ActiveSupport::Notifications.subscribe event do |_name, _started, _finished, _unique_id, data|
    statsd_increment data[:statsd_key]
  end
end
