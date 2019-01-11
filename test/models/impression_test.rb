# == Schema Information
#
# Table name: impressions
#
#  id                                          :uuid             not null, primary key
#  advertiser_id                               :bigint(8)        not null
#  publisher_id                                :bigint(8)        not null
#  campaign_id                                 :bigint(8)        not null
#  creative_id                                 :bigint(8)        not null
#  property_id                                 :bigint(8)        not null
#  ip_address                                  :string           not null
#  user_agent                                  :text             not null
#  country_code                                :string
#  postal_code                                 :string
#  latitude                                    :decimal(, )
#  longitude                                   :decimal(, )
#  displayed_at                                :datetime         not null
#  displayed_at_date                           :date             not null
#  clicked_at                                  :datetime
#  clicked_at_date                             :date
#  fallback_campaign                           :boolean          default(FALSE), not null
#  estimated_gross_revenue_fractional_cents    :float
#  estimated_property_revenue_fractional_cents :float
#  estimated_house_revenue_fractional_cents    :float
#  ad_template                                 :string
#  ad_theme                                    :string
#  organization_id                             :bigint(8)
#  uplift                                      :boolean          default(FALSE)
#

require "test_helper"

class ImpressionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
