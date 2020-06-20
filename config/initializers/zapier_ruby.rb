ZapierRuby.configure do |config|
  config.web_hooks = {
    example_zap: "webhook_id"
  }
  config.enable_logging = false

  # For new web hooks, you must provide this param
  config.account_id = ENV["ZAPIER_ACCOUNT_ID"] # Get this from the first part of your webhook URI

  # For older webhooks, you should override the base uri to the old uri
  # config.base_uri = "https://hooks.zapier.com/hooks/catch/"
end