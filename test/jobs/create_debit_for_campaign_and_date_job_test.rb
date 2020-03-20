require "test_helper"

class CreateDebitForCampaignAndDateJobTest < ActiveJob::TestCase
  test "debits are created correctly" do
    property = properties(:website)
    campaign = campaigns(:premium_bundled)
    campaign.creatives.sponsor.delete_all
    campaign.organization.organization_transactions.credits.create!(
      amount: Monetize.parse("$10,000 USD"),
      description: "Initial Credit",
      reference: "Test",
      posted_at: Time.current
    )
    campaign.organization.recalculate_balance!
    starting_balance = campaign.organization.reload.balance

    impressions = rand(500..1000).times.map {
      impression = campaign.impressions.build(
        id: SecureRandom.uuid,
        advertiser: campaign.user,
        creative: campaign.creative,
        publisher: property.user,
        property: property,
        ip_address: Faker::Internet.public_ip_v4_address,
        user_agent: Faker::Internet.user_agent,
        country_code: "US",
        province_code: "US-CA",
        postal_code: "94102",
        displayed_at: campaign.operative_dates.first,
        displayed_at_date: campaign.operative_dates.first
      )
      impression.calculate_estimated_revenue true
      impression.attributes
    }

    Impression.insert_all impressions
    CreateDebitForCampaignAndDateJob.perform_now campaign, campaign.operative_dates.first.iso8601
    gross_revenue_cents = Impression.all.sum(:estimated_gross_revenue_fractional_cents).round

    assert campaign.standard?
    assert OrganizationTransaction.count == 2
    assert OrganizationTransaction.debits.first.amount_cents == Impression.all.sum(:estimated_gross_revenue_fractional_cents).round
    assert campaign.organization.reload.balance == (starting_balance - Money.new(gross_revenue_cents, "USD"))
  end
end
