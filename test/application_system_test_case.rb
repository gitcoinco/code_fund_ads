require "test_helper"
require "capybara/cuprite"

Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1400, 1400],
    js_errors: false,
    headless: !(ENV["WATCH"] == "true"),
    process_timeout: 5
  )
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Watch tests execute in the browser with `WATCH=true` in your environment
  # ex: WATCH=true bin/rails test:system
  driven_by :cuprite
end
