# == Schema Information
#
# Table name: job_postings
#
#  id                         :bigint(8)        not null, primary key
#  organization_id            :bigint(8)
#  user_id                    :bigint(8)
#  campaign_id                :bigint(8)
#  status                     :string           default("pending"), not null
#  source                     :string           default("internal"), not null
#  source_identifier          :string
#  job_type                   :string           not null
#  company_name               :string
#  company_url                :string
#  company_logo_url           :string
#  title                      :string           not null
#  description                :text             not null
#  how_to_apply               :text
#  keywords                   :string           default([]), not null, is an Array
#  display_salary             :boolean          default(TRUE)
#  min_annual_salary_cents    :integer          default(0), not null
#  min_annual_salary_currency :string           default("USD"), not null
#  max_annual_salary_cents    :integer          default(0), not null
#  max_annual_salary_currency :string           default("USD"), not null
#  remote                     :boolean          default(FALSE), not null
#  remote_country_codes       :string           default([]), not null, is an Array
#  city                       :string
#  province_name              :string
#  province_code              :string
#  country_code               :string
#  url                        :text
#  start_date                 :date             not null
#  end_date                   :date             not null
#  full_text_search           :tsvector
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  company_email              :string
#  stripe_charge_id           :string
#  session_id                 :string
#  auto_renew                 :boolean          default(TRUE), not null
#  list_view_count            :integer          default(0), not null
#  detail_view_count          :integer          default(0), not null
#  coupon_id                  :bigint(8)
#  plan                       :string
#  offers                     :string           default([]), not null, is an Array
#

require "test_helper"

class JobPostingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
