require "test_helper"
require "faker"

class ImpressionsTest < ActionDispatch::IntegrationTest
  test "requesting an invalid impression display pixel returns a 202 Accepted" do
    get impression_path(SecureRandom.uuid, format: :gif)
    assert response.status == 202
  end
end
