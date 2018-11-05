# frozen_string_literal: true

# == Schema Information
#
# Table name: campaigns
#
#  id                :bigint(8)        not null, primary key
#  user_id           :bigint(8)
#  creative_id       :bigint(8)
#  status            :string           not null
#  fallback          :boolean          default(FALSE), not null
#  name              :string           not null
#  url               :text             not null
#  start_date        :date
#  end_date          :date
#  us_hours_only     :boolean          default(FALSE)
#  weekdays_only     :boolean          default(FALSE)
#  ecpm              :decimal(, )      not null
#  daily_budget      :decimal(, )      not null
#  total_budget      :decimal(, )      not null
#  countries         :string           default([]), is an Array
#  keywords          :string           default([]), is an Array
#  negative_keywords :string           default([]), is an Array
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
