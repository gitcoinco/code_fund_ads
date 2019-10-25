UpdateBrowserImpressionStatsJob.set(wait: 30.seconds).perform_later if Sidekiq.server?
