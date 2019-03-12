# == Schema Information
#
# Table name: daily_summaries
#
#  id                        :bigint(8)        not null, primary key
#  impressionable_type       :string           not null
#  impressionable_id         :bigint(8)        not null
#  scoped_by_type            :string
#  scoped_by_id              :bigint(8)
#  impressions_count         :integer          default(0), not null
#  fallbacks_count           :integer          default(0), not null
#  fallback_percentage       :decimal(, )      default(0.0), not null
#  clicks_count              :integer          default(0), not null
#  click_rate                :decimal(, )      default(0.0), not null
#  ecpm_cents                :integer          default(0), not null
#  ecpm_currency             :string           default("USD"), not null
#  cost_per_click_cents      :integer          default(0), not null
#  cost_per_click_currency   :string           default("USD"), not null
#  gross_revenue_cents       :integer          default(0), not null
#  gross_revenue_currency    :string           default("USD"), not null
#  property_revenue_cents    :integer          default(0), not null
#  property_revenue_currency :string           default("USD"), not null
#  house_revenue_cents       :integer          default(0), not null
#  house_revenue_currency    :string           default("USD"), not null
#  displayed_at_date         :date             not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require "test_helper"

class DailySummaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
