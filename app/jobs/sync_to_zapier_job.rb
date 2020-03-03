class SyncToZapierJob < ApplicationJob
  queue_as :default

  def perform
    return unless ENV["PIPEDRIVE_SYNC_HOOK_URL"].present?

    body = Campaign.premium.active.includes(:user, :organization).map { |campaign|
      {
        id: campaign.id,
        name: campaign.name,
        status: campaign.status,
        url: campaign.url,
        start_date: campaign.start_date.to_s("mm/dd/yyyy"),
        end_date: campaign.end_date.to_s("mm/dd/yyyy"),
        total_budget: campaign.total_budget.format,
        ecpm: campaign.ecpm.format,
        country_codes: campaign.country_codes,
        keywords: campaign.keywords,
        negative_keywords: campaign.negative_keywords,
        fixed_ecpm: campaign.fixed_ecpm,
        assigned_property_ids: campaign.assigned_property_ids,
        hourly_budget_cents: campaign.hourly_budget_cents,
        prohibited_property_ids: campaign.prohibited_property_ids,
        organization: {
          id: campaign.organization.id,
          name: campaign.organization.name,
          balance: campaign.organization.balance.format
        },
        user: {
          id: campaign.user.id,
          first_name: campaign.user.first_name,
          last_name: campaign.user.last_name,
          email: campaign.user.email
        }
      }
    }

    Typhoeus.post(ENV["PIPEDRIVE_SYNC_HOOK_URL"], body: body.to_json)
  end
end
