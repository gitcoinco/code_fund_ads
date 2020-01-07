require "test_helper"
require "capybara"

Capybara.default_max_wait_time = 5
`cat ../public/packs-test/manifest.json`

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
end
