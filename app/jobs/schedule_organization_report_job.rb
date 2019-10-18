class ScheduleOrganizationReportJob < ApplicationJob
  queue_as :default

  def perform(id:, deliver_at: nil)
    scheduled_report = ScheduledOrganizationReport.find(id)
    return unless scheduled_report
    return if scheduled_report.expired?
    return schedule_first_report(scheduled_report) if deliver_at.nil?
    generate_organization_report(scheduled_report)
    schedule_next_report(scheduled_report, deliver_at)
  end

  private

  def schedule_first_report(scheduled_report)
    deliver_at = if scheduled_report.start_date <= Date.today
      DateTime.current
    else
      scheduled_report.start_date.midnight
    end

    ScheduleOrganizationReportJob.set(wait_until: deliver_at).perform_later(id: scheduled_report.id, deliver_at: deliver_at)
    nil
  end

  def schedule_next_report(scheduled_report, deliver_at)
    new_deliver_at = case scheduled_report.frequency
      when "daily" then deliver_at + 1.day
      when "weekly" then deliver_at + 7.days
    end

    return if new_deliver_at > scheduled_report.end_date.midnight

    ScheduleOrganizationReportJob.set(wait_until: new_deliver_at).perform_later(id: scheduled_report.id, deliver_at: new_deliver_at)
    nil
  end

  def generate_organization_report(scheduled_report)
    start_date, end_date = case scheduled_report.dataset
      when "current_month" then [Date.today.beginning_of_month, Date.today.end_of_month]
      when "past_7_days" then [8.days.ago, Date.yesterday]
      when "past_30_days" then [31.days.ago, Date.yesterday]
      when "yesterday" then [Date.yesterday, Date.yesterday]
    end

    report = OrganizationReport.create!(
      organization_id: scheduled_report.organization_id,
      title: scheduled_report.subject,
      campaign_ids: scheduled_report.campaign_ids,
      start_date: start_date,
      end_date: end_date
    )

    GenerateOrganizationReportJob.perform_later(
      id: report.id,
      report_url: Rails.application.routes.url_helpers.organization_report_url(organization_id: scheduled_report.organization_id, id: report.id, host: ENV["DEFAULT_HOST"]),
      recipients: scheduled_report.recipients
    )
  end
end
