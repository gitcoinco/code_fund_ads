# == Schema Information
#
# Table name: daily_summaries
#
#  id                                  :bigint(8)        not null, primary key
#  record_type                         :string           not null
#  record_id                           :bigint(8)        not null
#  count                               :integer          default(0), not null
#  average_ecpm_cents                  :integer          default(0), not null
#  average_ecpm_currency               :string           default("USD"), not null
#  estimated_gross_revenue_cents       :integer          default(0), not null
#  estimated_gross_revenue_currency    :string           default("USD"), not null
#  estimated_property_revenue_cents    :integer          default(0), not null
#  estimated_property_revenue_currency :string           default("USD"), not null
#  estimated_house_revenue_cents       :integer          default(0), not null
#  estimated_house_revenue_currency    :string           default("USD"), not null
#  displayed_at_date                   :date             not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#

require 'test_helper'

class DailySummaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
