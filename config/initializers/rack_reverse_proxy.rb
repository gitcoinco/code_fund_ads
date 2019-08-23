Rails.application.config.middleware.use Rack::ReverseProxy do
  reverse_proxy_options preserve_host: true
  reverse_proxy "/gitcoinco", "https://github.com/gitcoinco"
end
