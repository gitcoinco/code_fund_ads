# frozen_string_literal: true

if Rails.env.development?
  require "rack-mini-profiler"

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)

  # set MemoryStore
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
  # Display mini_profiler on
  Rack::MiniProfiler.config.position = "bottom-right"
  # Displays the total number of SQL executions.
  Rack::MiniProfiler.config.show_total_sql_count = true
  # Enables sensitive debugging tools that can be used via the UI
  Rack::MiniProfiler.config.enable_advanced_debugging_tools = true
end
