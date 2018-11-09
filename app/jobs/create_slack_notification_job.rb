class CreateSlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(message)
    if ENV["SLACK_WEBHOOK_URL"].present?
      notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
      notifier.ping message
    end
  end
end
