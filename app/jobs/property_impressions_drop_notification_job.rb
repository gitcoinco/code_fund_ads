# Alerts the team when a property has a dramatic drop in impressions
# Scheduled via Heroku Scheduler
# SEE: lib/tasks/schedule.rake
class PropertyImpressionsDropNotificationJob < ApplicationJob
  queue_as :low
  IMPRESSIONS_THRESHOLD = 15

  def perform
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    properties = []

    Property.active.find_each do |property|
      next unless property.daily_summary_reports_by_campaign(2.days.ago, 1.day.ago).sum(&:impressions_count) < IMPRESSIONS_THRESHOLD
      next unless property.daily_summary_reports_by_campaign(3.days.ago, 2.day.ago).sum(&:impressions_count) >= IMPRESSIONS_THRESHOLD
      properties << property
    end

    return if properties.empty?

    send_slack_notification(slack_message(properties))
    send_email_notification(properties)
  end

  private

  def send_slack_notification(message)
    CreateSlackNotificationJob.perform_later text: message
  end

  def slack_message(properties)
    message = properties.map { |property| "- [#{property.name}](https://app.codefund.io/properties/#{property.id})\n" }
    message.unshift(":warning: <@UNXSRM09K> The following properties have had a drop in impressions :warning:\n\n")
    message.join
  end

  def send_email_notification(properties)
    PropertiesMailer.impressions_drop_email(properties).deliver_later
  end
end
