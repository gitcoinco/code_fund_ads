class CreateSlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(args)
    return unless ENV["SLACK_WEBHOOK_URL"].present?

    notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
    if args[:message].present?
      notifier.post text: args[:text], attachments: {text: args[:message]}, format: :markdown
    else
      notifier.post text: args[:text], format: :markdown
    end
  end
end
