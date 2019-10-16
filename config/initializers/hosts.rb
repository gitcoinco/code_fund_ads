Rails.application.config.hosts << ENV["NGROK_HOST"] if Rails.env.development? && ENV["NGROK_HOST"].present?
