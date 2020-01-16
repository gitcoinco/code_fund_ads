return unless Rails.env.development?

if ENV["NGROK_HOST"].present?
  Rails.application.config.hosts << ENV["NGROK_HOST"]
elsif ENV["NGROK_SUBDOMAIN"].present?
  Rails.application.config.hosts << "#{ENV["NGROK_SUBDOMAIN"]}.ngrok.io"
end
