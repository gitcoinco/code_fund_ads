Rails.application.config.action_cable.worker_pool_size = ENV.fetch("ACTION_CABLE_MAX_THREADS", 5).to_i
ActionCable.server.config.logger = Logger.new(nil) if ENV["SILENCE_ACTION_CABLE"] == "true"
