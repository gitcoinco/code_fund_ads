require "test_helper"

class AudienceTest < ActiveSupport::TestCase
  test "ecpm pricing for US" do
    actual = Audience.all.map { |a| [a.name, a.ecpm_for_country_code("US").format] }
    expected = [
      ["Blockchain", "$10.00"],
      ["CSS & Design", "$4.50"],
      ["DevOps", "$6.50"],
      ["Game Development", "$4.25"],
      ["JavaScript & Frontend", "$6.25"],
      ["Miscellaneous", "$4.25"],
      ["Mobile Development", "$4.50"],
      ["Web Development & Backend", "$5.00"],
    ]
    assert actual == expected
  end
end
