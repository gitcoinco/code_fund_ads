# == Schema Information
#
# Table name: properties
#
#  id                             :bigint           not null, primary key
#  user_id                        :bigint           not null
#  property_type                  :string           not null
#  status                         :string           not null
#  name                           :string           not null
#  description                    :text
#  url                            :text             not null
#  ad_template                    :string
#  ad_theme                       :string
#  language                       :string           not null
#  keywords                       :string           default([]), not null, is an Array
#  prohibited_advertiser_ids      :bigint           default([]), not null, is an Array
#  prohibit_fallback_campaigns    :boolean          default(FALSE), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  legacy_id                      :uuid
#  revenue_percentage             :decimal(, )      default(0.6), not null
#  assigned_fallback_campaign_ids :bigint           default([]), not null, is an Array
#  restrict_to_assigner_campaigns :boolean          default(FALSE), not null
#  fallback_ad_template           :string
#  fallback_ad_theme              :string
#  responsive_behavior            :string           default("none"), not null
#  audience                       :string
#

require "test_helper"

class PropertyTest < ActiveSupport::TestCase
end
