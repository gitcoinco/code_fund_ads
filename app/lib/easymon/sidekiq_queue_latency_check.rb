module Easymon
  class SidekiqQueueLatencyCheck
    def check
      latency = Sidekiq::Queue.new.latency
      status = latency < 30

      [status, "#{status ? "ok" : "not-ok"} - #{latency}"]
    rescue
      [false, "Down"]
    end
  end
end
