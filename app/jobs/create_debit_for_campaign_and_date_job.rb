# Add a daily debit OrganizationTransaction for the passed campaign and date
# This job is idempotent, meaning it's safe to run multiple times with the same args
# it will only produce a single OrganizationTransaction
class CreateDebitForCampaignAndDateJob < ApplicationJob
  queue_as :critical

  def perform(campaign_id, date_string)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    date = Date.parse(date_string)
    campaign = Campaign.includes(:organization).available_on(date).find_by(id: campaign_id)
    return unless campaign

    amount = campaign.daily_consumed_budget(date, fresh: true)
    return unless amount > 0

    attrs = {
      organization_id: campaign.organization_id,
      transaction_type: ENUMS::ORGANIZATION_TRANSACTION_TYPES::DEBIT,
      reference: [campaign.id, date.iso8601].join(":"),
    }

    debit = OrganizationTransaction.find_by(attrs)
    return if debit # transaction already exists

    debit = OrganizationTransaction.new(attrs.merge(
      description: "Daily Spend on [#{date.iso8601}] for Campaign [#{campaign.id}: #{campaign.name}]",
      amount: amount,
      posted_at: Time.current,
    ))

    campaign.organization.balance = campaign.organization.balance - amount

    Organization.transaction do
      debit.save!
      campaign.organization.save!
    end
  end
end
