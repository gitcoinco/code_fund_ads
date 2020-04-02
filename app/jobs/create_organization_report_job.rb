class CreateOrganizationReportJob < ApplicationJob
  queue_as :default

  def perform(id:)
    organization = Organization.find_by(id: id)
    return unless organization
    campaigns = organization.campaigns.active
    return unless campaigns.exists?
    organization_report = build_report(organization, campaigns)
    if organization_report.save
      GenerateOrganizationReportJob.perform_later(
        id: organization_report.id,
        report_url: Rails.application.routes.url_helpers.organization_report_url(organization_id: organization_report.organization_id, id: organization_report.id, host: ENV["DEFAULT_HOST"]),
        recipients: organization_report.recipients
      )
    end
  end

  private

  def build_report(organization, campaigns)
    recipients = organization.users.map(&:email)
    recipients << ENUMS::EMAIL_ADDRESSES::ERIC

    organization.organization_reports.build(
      title: "#{organization.name} Summary Report",
      start_date: campaigns.minimum(:start_date),
      end_date: campaigns.maximum(:end_date),
      campaign_ids: campaigns.map(&:id),
      recipients: recipients
    )
  end
end
