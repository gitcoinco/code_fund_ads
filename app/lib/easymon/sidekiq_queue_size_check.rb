module Easymon
  class SidekiqQueueSizeCheck
    def check
      length = Sidekiq::Queue.all.sum(&:size)
      status = length < 25_000

      [status, "#{status ? "low" : "high"} - #{length}"]
    rescue
      [false, "Down"]
    end
  end
end
