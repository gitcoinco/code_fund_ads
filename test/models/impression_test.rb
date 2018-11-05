# frozen_string_literal: true

# == Schema Information
#
# Table name: impressions
#
#  id                :uuid             not null, primary key
#  campaign_id       :bigint(8)
#  property_id       :bigint(8)
#  ip                :string
#  user_agent        :text
#  country           :string
#  postal_code       :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  valid             :boolean          default(FALSE), not null
#  reason            :string
#  displayed_at_date :date
#  clicked_at_date   :date
#  clicked_at        :datetime
#  fallback_campaign :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require "test_helper"

class ImpressionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
