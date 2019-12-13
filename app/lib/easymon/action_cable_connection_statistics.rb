module Easymon
  class ActionCableConnectionStatistics
    def check
      count = ActionCable.server.open_connections_statistics.count
      status = count < 100

      [status, "#{status ? "low" : "high"} - #{count}"]
    rescue
      [false, "Down"]
    end
  end
end
