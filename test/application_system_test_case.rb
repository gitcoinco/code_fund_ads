require "test_helper"
require "capybara"

Capybara.default_max_wait_time = 5
`ls ../public/`
`ls ../public/packs-test/`

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
end
