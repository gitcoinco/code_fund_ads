class CreateNewPropertyNotificationJob < ApplicationJob
  queue_as :low

  def perform(property)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    @property = property
    return unless @property

    send_slack_notification
    send_email_notification
  end

  private

  def send_slack_notification
    CreateSlackNotificationJob.perform_later text: slack_message
  end

  def slack_message
    ":house: Property #{@property.name} just registered by #{@property.user&.name}. [View Property](https://app.codefund.io/properties/#{@property.id})"
  end

  def send_email_notification
    PropertiesMailer.new_property_email(@property).deliver_later
  end
end
