begin
  require "sidekiq/api"
rescue LoadError
end

class SidekiqQueueSizeHealthCheck < OkComputer::SizeThresholdCheck
  attr_accessor :queue

  def initialize(queue, threshold = 2500)
    self.queue = queue
    self.name = "Sidekiq queue '#{queue}' size"
    self.threshold = Integer(threshold)
  end

  def size
    Sidekiq::Queue.new(queue).size
  end
end

OkComputer.check_in_parallel = true
OkComputer::Registry.register "ruby", OkComputer::RubyVersionCheck.new
OkComputer::Registry.register "active-record", OkComputer::ActiveRecordCheck.new
OkComputer::Registry.register "cache", OkComputer::GenericCacheCheck.new
OkComputer::Registry.register "redis-queue", OkComputer::RedisCheck.new(url: ENV["REDIS_QUEUE_URL"])
OkComputer::Registry.register "redis-cache", OkComputer::RedisCheck.new(url: ENV["REDIS_CACHE_URL"])

queue_names = %i[
  critical
  impression
  click
  default
]

queue_names.each do |queue_name|
  OkComputer::Registry.register "queue/#{queue_name}", SidekiqQueueSizeHealthCheck.new(queue_name, ENV.fetch("MAX_QUEUE_SIZE", 2500).to_i)
end
