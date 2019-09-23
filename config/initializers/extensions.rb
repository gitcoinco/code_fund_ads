Rails.application.config.to_prepare do
  load Rails.root.join("app/lib/extensions.rb")
end
