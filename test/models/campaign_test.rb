# == Schema Information
#
# Table name: campaigns
#
#  id                    :bigint(8)        not null, primary key
#  user_id               :bigint(8)
#  creative_id           :bigint(8)
#  status                :string           not null
#  fallback              :boolean          default(FALSE), not null
#  name                  :string           not null
#  url                   :text             not null
#  start_date            :date
#  end_date              :date
#  us_hours_only         :boolean          default(FALSE)
#  weekdays_only         :boolean          default(FALSE)
#  total_budget_cents    :integer          default(0), not null
#  total_budget_currency :string           default("USD"), not null
#  daily_budget_cents    :integer          default(0), not null
#  daily_budget_currency :string           default("USD"), not null
#  ecpm_cents            :integer          default(0), not null
#  ecpm_currency         :string           default("USD"), not null
#  countries             :string           default([]), is an Array
#  keywords              :string           default([]), is an Array
#  negative_keywords     :string           default([]), is an Array
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  setup do
    @campaign = campaigns(:code_fund)
  end

  test "initial campaign budgets" do
    assert @campaign.total_budget == Monetize.parse("$5,000.00 USD")
    assert @campaign.daily_budget == Monetize.parse("$55.00 USD")
    assert @campaign.ecpm == Monetize.parse("$3.00 USD")
    assert @campaign.total_impressions_count == 0
    assert @campaign.total_impressions_per_mille == 0
    assert @campaign.total_consumed_budget == Monetize.parse("$0.00 USD")
    assert @campaign.total_remaining_budget == @campaign.total_budget
    assert @campaign.total_operative_days == 91
    assert @campaign.estimated_max_total_impression_count == 1_666_667
    assert @campaign.estimated_max_daily_impression_count == 18_334
    refute @campaign.budget_surplus?
  end

  test "restricting to weekdays impacts the numbers" do
    @campaign.update weekdays_only: true
    assert @campaign.total_operative_days < 90
    assert @campaign.budget_surplus?
    assert @campaign.recommended_daily_budget > @campaign.daily_budget
    assert @campaign.recommended_end_date > @campaign.end_date
  end

  test "increasing ecpm up impacts the numbers" do
    @campaign.update ecpm: Monetize.parse("$4.00 USD")
    assert @campaign.estimated_max_total_impression_count == 1_250_000
    assert @campaign.estimated_max_daily_impression_count == 13_750
  end

  test "decreasing ecpm down impacts the numbers" do
    @campaign.update ecpm: Monetize.parse("$2.00 USD")
    assert @campaign.estimated_max_total_impression_count == 2_500_000
    assert @campaign.estimated_max_daily_impression_count == 27_500
  end

  test "increasing total_budget impacts the numbers" do
    @campaign.update total_budget: Monetize.parse("$8,000 USD")
    assert @campaign.estimated_max_total_impression_count == 2_666_667
    assert @campaign.budget_surplus?
    assert @campaign.recommended_daily_budget > @campaign.daily_budget
    assert @campaign.recommended_end_date > @campaign.end_date
  end

  test "decreasing daily_budget yields a budget surplus" do
    original_count = @campaign.estimated_max_remaining_impression_count
    @campaign.update daily_budget: Monetize.parse("$20 USD")
    assert @campaign.estimated_max_remaining_impression_count < original_count
    assert @campaign.budget_surplus?
    assert @campaign.recommended_daily_budget > @campaign.daily_budget
    assert @campaign.recommended_end_date > @campaign.end_date
  end
end
