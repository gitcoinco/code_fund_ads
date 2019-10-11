require "test_helper"

class RegionTest < ActiveSupport::TestCase
  test "ecpm pricing for audience" do
    assert Region.find(1).ecpm(Audience.blockchain).format == "$10.00"
    assert Region.find(2).ecpm(Audience.mobile_development).format == "$3.50"
    assert Region.find(3).ecpm(Audience.dev_ops).format == "$2.50"
  end

  test "region one pricing" do
    region = Region.find(1)

    assert region.blockchain_ecpm.format == "$10.00"
    assert region.css_and_design_ecpm.format == "$4.50"
    assert region.dev_ops_ecpm.format == "$6.50"
    assert region.game_development_ecpm.format == "$4.25"
    assert region.javascript_and_frontend_ecpm.format == "$6.25"
    assert region.miscellaneous_ecpm.format == "$4.25"
    assert region.mobile_development_ecpm.format == "$4.50"
    assert region.web_development_and_backend_ecpm.format == "$5.00"
  end

  test "region two pricing" do
    region = Region.find(2)

    assert region.blockchain_ecpm.format == "$9.00"
    assert region.css_and_design_ecpm.format == "$3.50"
    assert region.dev_ops_ecpm.format == "$5.50"
    assert region.game_development_ecpm.format == "$3.25"
    assert region.javascript_and_frontend_ecpm.format == "$5.25"
    assert region.miscellaneous_ecpm.format == "$3.25"
    assert region.mobile_development_ecpm.format == "$3.50"
    assert region.web_development_and_backend_ecpm.format == "$4.00"
  end

  test "region three pricing" do
    region = Region.find(3)

    assert region.blockchain_ecpm.format == "$6.00"
    assert region.css_and_design_ecpm.format == "$0.50"
    assert region.dev_ops_ecpm.format == "$2.50"
    assert region.game_development_ecpm.format == "$0.25"
    assert region.javascript_and_frontend_ecpm.format == "$2.25"
    assert region.miscellaneous_ecpm.format == "$0.25"
    assert region.mobile_development_ecpm.format == "$0.50"
    assert region.web_development_and_backend_ecpm.format == "$1.00"
  end
end
