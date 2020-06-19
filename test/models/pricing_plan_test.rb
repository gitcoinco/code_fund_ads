# == Schema Information
#
# Table name: pricing_plans
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pricing_plans_on_name  (name) UNIQUE
#
require "test_helper"

class PricingPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
