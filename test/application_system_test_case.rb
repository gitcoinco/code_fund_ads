require "test_helper"

puts "WAIT TIME"
puts Capybara.default_max_wait_time
Capybara.default_max_wait_time = 90
# Chrome headless driver
Capybara.register_driver :headless_chrome do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: {browser: "ALL"})
  opts = Selenium::WebDriver::Chrome::Options.new

  chrome_args = %w[--headless --no-sandbox --disable-gpu --window-size=1400,1400 --remote-debugging-port=9222]
  chrome_args.each { |arg| opts.add_argument(arg) }
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts, desired_capabilities: caps)
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
end
