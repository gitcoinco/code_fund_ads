# == Schema Information
#
# Table name: organization_reports
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  title           :string           not null
#  status          :string           default("pending"), not null
#  start_date      :date             not null
#  end_date        :date             not null
#  campaign_ids    :text             default([]), is an Array
#  pdf_url         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class OrganizationReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
