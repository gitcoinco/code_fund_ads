require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Watch tests execute in the browser with `WATCH=true` in your environment
  # ex: WATCH=true bin/rails test:system
  driven_by :selenium, using: ENV["WATCH"] == "true" ? :chrome : :headless_chrome
end
