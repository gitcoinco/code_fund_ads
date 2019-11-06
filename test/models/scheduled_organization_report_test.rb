# == Schema Information
#
# Table name: scheduled_organization_reports
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  subject         :text             not null
#  start_date      :date             not null
#  end_date        :date             not null
#  frequency       :string           not null
#  dataset         :string           not null
#  campaign_ids    :bigint           default([]), not null, is an Array
#  recipients      :string           default([]), not null, is an Array
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class ScheduledOrganizationReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
