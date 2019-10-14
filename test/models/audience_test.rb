# == Schema Information
#
# Table name: audiences
#
#  id               :integer          primary key
#  name             :text
#  ecpm_column_name :text
#  keywords         :text             is an Array
#

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

  test "ecpm pricing for FR" do
    actual = Audience.all.map { |a| [a.name, a.ecpm_for_country_code("FR").format] }
    expected = [
      ["Blockchain", "$9.00"],
      ["CSS & Design", "$3.50"],
      ["DevOps", "$5.50"],
      ["Game Development", "$3.25"],
      ["JavaScript & Frontend", "$5.25"],
      ["Miscellaneous", "$3.25"],
      ["Mobile Development", "$3.50"],
      ["Web Development & Backend", "$4.00"],
    ]
    assert actual == expected
  end

  test "ecpm pricing for IN" do
    actual = Audience.all.map { |a| [a.name, a.ecpm_for_country_code("IN").format] }
    expected = [
      ["Blockchain", "$6.00"],
      ["CSS & Design", "$0.50"],
      ["DevOps", "$2.50"],
      ["Game Development", "$0.25"],
      ["JavaScript & Frontend", "$2.25"],
      ["Miscellaneous", "$0.25"],
      ["Mobile Development", "$0.50"],
      ["Web Development & Backend", "$1.00"],
    ]
    assert actual == expected
  end

  test "ecpm pricing for nil" do
    actual = Audience.all.map { |a| [a.name, a.ecpm_for_country_code("nil").format] }
    expected = [
      ["Blockchain", "$6.00"],
      ["CSS & Design", "$0.50"],
      ["DevOps", "$2.50"],
      ["Game Development", "$0.25"],
      ["JavaScript & Frontend", "$2.25"],
      ["Miscellaneous", "$0.25"],
      ["Mobile Development", "$0.50"],
      ["Web Development & Backend", "$1.00"],
    ]
    assert actual == expected
  end
end
