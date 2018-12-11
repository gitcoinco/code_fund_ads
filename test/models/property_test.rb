# == Schema Information
#
# Table name: properties
#
#  id                          :bigint(8)        not null, primary key
#  user_id                     :bigint(8)        not null
#  property_type               :string           not null
#  status                      :string           not null
#  name                        :string           not null
#  description                 :text
#  url                         :text             not null
#  ad_template                 :string
#  ad_theme                    :string
#  language                    :string           not null
#  keywords                    :string           default([]), not null, is an Array
#  prohibited_advertiser_ids   :bigint(8)        default([]), not null, is an Array
#  prohibit_fallback_campaigns :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  legacy_id                   :uuid
#  revenue_percentage          :decimal(, )      default(0.5), not null
#

require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
