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
