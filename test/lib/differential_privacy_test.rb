require "test_helper"

class DifferentialPrivacyTest < ActiveSupport::TestCase
  test "basic flip" do
    value = 1
    substitutes = (1..10).to_a
    results = 1000.times.each_with_object({}) { |_, memo|
      result = DifferentialPrivacy.flip(value, substitutes.sample)
      memo[result] ||= 0
      memo[result] += 1
    }
    hit_percentage = results[value] / 1000.to_f
    puts results.inspect
    puts "True Value: #{hit_percentage * 100}%"
    puts "Fake Value: #{(1 - hit_percentage) * 100}%"
    assert hit_percentage.between?(0.65, 0.85)
  end
end
