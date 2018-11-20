Rails.application.config.after_initialize do
  load Rails.root.join("app/lib/extensions.rb")
end
