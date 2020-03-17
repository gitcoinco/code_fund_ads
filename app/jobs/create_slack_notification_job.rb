class CreateSlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(args)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    return unless Rails.env.production?
    return unless ENV["SLACK_WEBHOOK_URL"].present?

    notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
    if args[:message].present?
      notifier.post text: args[:text], attachments: {text: args[:message]}, format: :markdown
    else
      notifier.post text: args[:text], format: :markdown
    end
  end
end
