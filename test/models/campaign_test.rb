# frozen_string_literal: true

# == Schema Information
#
# Table name: campaigns
#
#  id                             :uuid             not null, primary key
#  name                           :string(255)      not null
#  redirect_url                   :text             not null
#  status                         :integer          default(0), not null
#  ecpm                           :decimal(10, 2)   not null
#  budget_daily_amount            :decimal(10, 2)   not null
#  total_spend                    :decimal(10, 2)   not null
#  user_id                        :uuid
#  inserted_at                    :datetime         not null
#  updated_at                     :datetime         not null
#  audience_id                    :uuid
#  creative_id                    :uuid
#  included_countries             :string(255)      default([]), is an Array
#  impression_count               :integer          default(0), not null
#  start_date                     :datetime
#  end_date                       :datetime
#  us_hours_only                  :boolean          default(FALSE)
#  weekdays_only                  :boolean          default(FALSE)
#  included_programming_languages :string(255)      default([]), is an Array
#  included_topic_categories      :string(255)      default([]), is an Array
#  excluded_programming_languages :string(255)      default([]), is an Array
#  excluded_topic_categories      :string(255)      default([]), is an Array
#  fallback_campaign              :boolean          default(FALSE), not null
#

require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
