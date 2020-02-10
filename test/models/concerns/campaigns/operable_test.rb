require "test_helper"

class Campaigns::OperableTest < ActiveSupport::TestCase
  setup do
    start_date = Date.parse("2020-01-01")
    @campaign = amend campaigns: :premium,
                      start_date: start_date,
                      end_date: start_date.advance(months: 3),
                      keywords: ENUMS::KEYWORDS.keys.sample(5)
    @today = @campaign.start_date.to_time.advance(days: 15)
    travel_to @today
  end

  test "#total_operative_days for all days" do
    assert_equal 92, @campaign.total_operative_days
  end

  test "#total_operative_days for weekdays only" do
    @campaign.stubs(weekdays_only?: true)
    assert_equal 66, @campaign.total_operative_days
  end

  test "#remaining_operative_days" do
    assert_equal 77, @campaign.remaining_operative_days
  end

  test "#consumed_operative_days" do
    assert_equal 15, @campaign.consumed_operative_days
  end

  test "#consumed_operative_days for unending campaign" do
    @campaign.stubs(unending?: true)
    assert_equal 16, @campaign.consumed_operative_days
  end

  test "operable with total budget and remaining operative days" do
    @campaign.stubs(total_remaining_budget: Money.new(50000, "USD"))
    assert @campaign.operable?
  end

  test "not operable with no total budget and remaining operative days" do
    @campaign.stubs(total_remaining_budget: Money.new(0, "USD"))
    assert_not @campaign.operable?
  end

  test "not operable with total budget and no remaining operative days" do
    @campaign.stubs(total_remaining_budget: Money.new(50000, "USD"))
    @campaign.stubs(remaining_operative_days: 0)
    assert_not @campaign.operable?
  end
end
