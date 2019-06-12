# == Schema Information
#
# Table name: property_traffic_estimates
#
#  id                             :bigint           not null, primary key
#  property_id                    :bigint           not null
#  site_worth_cents               :integer          default(0), not null
#  site_worth_currency            :string           default("USD"), not null
#  visitors_daily                 :integer          default(0)
#  visitors_monthly               :integer          default(0)
#  visitors_yearly                :integer          default(0)
#  pageviews_daily                :integer          default(0)
#  pageviews_monthly              :integer          default(0)
#  pageviews_yearly               :integer          default(0)
#  revenue_daily_cents            :integer          default(0), not null
#  revenue_daily_currency         :string           default("USD"), not null
#  revenue_monthly_cents          :integer          default(0), not null
#  revenue_monthly_currency       :string           default("USD"), not null
#  revenue_yearly_cents           :integer          default(0), not null
#  revenue_yearly_currency        :string           default("USD"), not null
#  alexa_rank_3_months            :integer          default(0)
#  alexa_rank_1_month             :integer          default(0)
#  alexa_rank_7_days              :integer          default(0)
#  alexa_rank_1_day               :integer          default(0)
#  alexa_rank_delta_3_months      :integer          default(0)
#  alexa_rank_delta_1_month       :integer          default(0)
#  alexa_rank_delta_7_days        :integer          default(0)
#  alexa_rank_delta_1_day         :integer          default(0)
#  alexa_reach_3_months           :integer          default(0)
#  alexa_reach_1_month            :integer          default(0)
#  alexa_reach_7_days             :integer          default(0)
#  alexa_reach_1_day              :integer          default(0)
#  alexa_reach_delta_3_months     :integer          default(0)
#  alexa_reach_delta_1_month      :integer          default(0)
#  alexa_reach_delta_7_days       :integer          default(0)
#  alexa_reach_delta_1_day        :integer          default(0)
#  alexa_pageviews_3_months       :float
#  alexa_pageviews_1_month        :float
#  alexa_pageviews_7_days         :float
#  alexa_pageviews_1_day          :float
#  alexa_pageviews_delta_3_months :float
#  alexa_pageviews_delta_1_month  :float
#  alexa_pageviews_delta_7_days   :float
#  alexa_pageviews_delta_1_day    :float
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require "test_helper"

class PropertyTrafficEstimateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
