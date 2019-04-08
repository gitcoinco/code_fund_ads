require "test_helper"

class CreateDebitForCampaignAndDateJobTest < ActiveJob::TestCase
  test "debits are created correctly" do
    property = properties(:website)
    campaign = amend(campaigns: :premium, start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date)

    rand(5000).times do
      campaign.impressions.create!(
        advertiser: campaign.user,
        creative: campaign.creative,
        publisher: property.user,
        property: property,
        ip_address: ip_address("US"),
        user_agent: Faker::Internet.user_agent,
        country_code: "US",
        province_code: "US-CA",
        postal_code: "94102",
        displayed_at: 1.day.ago,
        displayed_at_date: 1.day.ago.to_date
      )
    end

    starting_balance = campaign.organization.balance
    CreateDebitForCampaignAndDateJob.perform_now campaign, 1.day.ago.to_date.iso8601
    gross_revenue_cents = Impression.all.sum(:estimated_gross_revenue_fractional_cents).round

    assert OrganizationTransaction.count == 1
    assert OrganizationTransaction.first.amount_cents == Impression.all.sum(:estimated_gross_revenue_fractional_cents).round
    assert campaign.organization.reload.balance == (starting_balance - Money.new(gross_revenue_cents, "USD"))
  end
end
