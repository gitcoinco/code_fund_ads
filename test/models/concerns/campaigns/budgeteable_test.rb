require "test_helper"

class Campaigns::BudgeteableTest < ActiveSupport::TestCase
  setup do
    @campaign = campaigns(:exclusive)
  end

  test "daily_remaining_budget_percentage is 0% when no daily budget" do
    @campaign.update daily_budget_cents: 0
    assert @campaign.daily_remaining_budget_percentage == 0
  end

  test "daily_remaining_budget_percentage is 100% when no spend" do
    @campaign.singleton_class.define_method(:daily_remaining_budget) { |*args| daily_budget }
    assert @campaign.daily_remaining_budget_percentage == 100.0
  end

  test "daily_remaining_budget_percentage is 40% when 60% spent" do
    @campaign.singleton_class.define_method(:daily_remaining_budget) { |*args| daily_budget * 0.4 }
    assert @campaign.daily_remaining_budget_percentage == 40.0
  end
end
