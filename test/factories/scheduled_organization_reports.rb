FactoryBot.define do
  date = Date.current.beginning_of_month

  factory :scheduled_organization_report do
    association :organization

    subject { "My Scheduled Report" }
    start_date { date }
    end_date { start_date.advance(months: 1) }
    recipients { ["eric@codefund.io", "nate@codefund.io"] }
    frequency { ENUMS::SCHEDULED_ORGANIZATION_REPORT_FREQUENCIES.values.sample }
    dataset { ENUMS::SCHEDULED_ORGANIZATION_REPORT_DATASETS.values.sample }
    campaign_ids { organization.campaigns&.pluck(:id) }
  end
end
