Rails.application.config.after_initialize do
  load Rails.root.join("app/lib/easymon/sidekiq_queue_size_check.rb")
  load Rails.root.join("app/lib/easymon/sidekiq_queue_latency_check.rb")
  load Rails.root.join("app/lib/easymon/action_cable_connection_statistics.rb")
end

Easymon::Repository.add(
  "database",
  Easymon::ActiveRecordCheck.new(ActiveRecord::Base),
  :critical
)
Easymon::Repository.add("redis",
  Easymon::RedisCheck.new(
    YAML.load(
      ERB.new(
        File.read(Rails.root.join("config/cable.yml"))
      ).result
    )[Rails.env].symbolize_keys
  ))

Easymon::Repository.add(
  "memcached",
  Easymon::MemcachedCheck.new(Rails.cache)
)

Easymon::Repository.add(
  "sidekiq queue size",
  Easymon::SidekiqQueueSizeCheck.new
)

Easymon::Repository.add(
  "sidekiq queue latency",
  Easymon::SidekiqQueueLatencyCheck.new
)

Easymon::Repository.add(
  "action cable connections",
  Easymon::ActionCableConnectionStatistics.new
)

Easymon::Repository.add(
  "metabase",
  Easymon::HttpCheck.new("https://metabase.codefund.io")
)

Easymon::Repository.add(
  "wordpress",
  Easymon::HttpCheck.new("https://codefund.io")
)
