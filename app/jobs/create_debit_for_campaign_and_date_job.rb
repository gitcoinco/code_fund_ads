# Add a daily debit OrganizationTransaction for the passed campaign and date
# This job is idempotent, meaning it's safe to run multiple times with the same args
# it will only produce a single OrganizationTransaction
class CreateDebitForCampaignAndDateJob < ApplicationJob
  queue_as :default

  def perform(campaign_id, date_string)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    date = Date.parse(date_string)
    return unless date.past?
    campaign = Campaign.includes(:organization).available_on(date).find_by(id: campaign_id)
    return unless campaign

    cents = campaign.impressions.on(date).sum(:estimated_gross_revenue_fractional_cents).round
    return unless cents > 0
    amount = Money.new(cents, "USD")

    ActiveRecord::Base.transaction do
      OrganizationTransaction
        .where(
          organization_id: campaign.organization_id,
          transaction_type: ENUMS::ORGANIZATION_TRANSACTION_TYPES::DEBIT,
          reference: [campaign.id, date.iso8601].join(":"),
        )
        .first_or_create!(
          description: "Daily Spend on [#{date.iso8601}] for Campaign [#{campaign.id}: #{campaign.name}]",
          amount: amount,
          posted_at: Time.current,
        )
      campaign.organization.recalculate_balance!
    end
  rescue => e
    Rollbar.error e
  end
end
