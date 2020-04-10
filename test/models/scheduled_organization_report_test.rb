# == Schema Information
#
# Table name: scheduled_organization_reports
#
#  id              :bigint           not null, primary key
#  campaign_ids    :bigint           default([]), not null, is an Array
#  dataset         :string           not null
#  end_date        :date             not null
#  frequency       :string           not null
#  recipients      :string           default([]), not null, is an Array
#  start_date      :date             not null
#  subject         :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_scheduled_organization_reports_on_organization_id  (organization_id)
#

require "test_helper"

class ScheduledOrganizationReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
