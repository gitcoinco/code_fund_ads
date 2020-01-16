require "test_helper"

Capybara.ignore_hidden_elements = false
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.current_driver = Capybara.javascript_driver

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
end
