# frozen_string_literal: true

ScreenshotMachine.configure do |config|
  config.key        = ENV["SCREENSHOT_MACHINE_KEY"]
  config.size       = "1024x768"
end
