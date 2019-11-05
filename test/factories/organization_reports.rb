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
#  pdf_url         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  campaign_ids    :bigint           default([]), not null, is an Array
#

FactoryBot.define do
  date = Date.current.beginning_of_month

  factory :organization_report do
    association :organization

    title { "My Scheduled Report" }
    start_date { date }
    end_date { start_date.advance(months: 1) }
    status { "active" }
  end
end
