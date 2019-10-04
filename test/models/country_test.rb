require "test_helper"

class CountryTest < ActiveSupport::TestCase
  setup do
    @base_ecpm = Monetize.parse("$4.00 USD")
    @country = Country.new
  end

  test "Country find by iso code" do
    assert Country.find("US").name == "United States of America"
    assert Country.find("GB").name == "United Kingdom of Great Britain and Northern Ireland"
    assert Country.find("FR").name == "France"
  end

  test "ecpm with default unknown multiplier" do
    assert @country.ecpm(base: @base_ecpm) == Monetize.parse("$0.20 USD")
  end

  test "ecpm with default multiplier of 0 is set to minimum of $0.10 USD" do
    @country.subregion_cpm_multiplier = 0.0
    assert @country.ecpm(base: @base_ecpm) == Monetize.parse("$0.10 USD")
  end

  test "ecpm with default multiplier of 1" do
    @country.subregion_cpm_multiplier = 1
    assert @country.ecpm(base: @base_ecpm) == @base_ecpm
  end

  test "ecpm with default multiplier 0.72" do
    @country.subregion_cpm_multiplier = 0.72
    assert @country.ecpm(base: @base_ecpm) == Monetize.parse("$2.88 USD")
  end

  test "ecpm with default multiplier on misc countries" do
    assert Country.find("US").ecpm(base: @base_ecpm) == Monetize.parse("$4.00 USD")
    assert Country.find("FR").ecpm(base: @base_ecpm) == Monetize.parse("$3.20 USD")
    assert Country.find("MX").ecpm(base: @base_ecpm) == Monetize.parse("$2.00 USD")
    assert Country.find("RO").ecpm(base: @base_ecpm) == Monetize.parse("$1.20 USD")
    assert Country.find("IN").ecpm(base: @base_ecpm) == Monetize.parse("$0.40 USD")
    assert Country.find("CN").ecpm(base: @base_ecpm) == Monetize.parse("$0.40 USD")
  end

  test "ecpm with country unknown multiplier" do
    assert @country.ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$0.20 USD")
  end

  test "ecpm with country multiplier of 0 is set to minimum of $0.10 USD" do
    @country.country_cpm_multiplier = 0.0
    assert @country.ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$0.10 USD")
  end

  test "ecpm with country multiplier of 1" do
    @country.country_cpm_multiplier = 1
    assert @country.ecpm(base: @base_ecpm, multiplier: :country) == @base_ecpm
  end

  test "ecpm with country multiplier 0.72" do
    @country.country_cpm_multiplier = 0.72
    assert @country.ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$2.88 USD")
  end

  test "ecpm with country multiplier on misc countries" do
    assert Country.find("US").ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$4.00 USD")
    assert Country.find("FR").ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$1.44 USD")
    assert Country.find("MX").ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$2.00 USD")
    assert Country.find("RO").ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$1.24 USD")
    assert Country.find("IN").ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$0.92 USD")
    assert Country.find("CN").ecpm(base: @base_ecpm, multiplier: :country) == Monetize.parse("$0.20 USD")
  end
end
