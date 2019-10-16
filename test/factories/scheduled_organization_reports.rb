FactoryBot.define do
  factory :scheduled_organization_report do
    organization_id { "" }
    subject { "MyText" }
    frequency { "MyString" }
    dataset { "MyString" }
    campaign_ids { "" }
  end
end
