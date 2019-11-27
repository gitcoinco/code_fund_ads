require "import_export"

class CheckConsolidatedScreeningListJob < ApplicationJob
  queue_as :low

  def perform(user)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    @user = user
    return unless @user

    return if ImportExport::Client.new.search(name: @user.name).empty?

    send_slack_notification
    send_email_notification
  end

  private

  def send_slack_notification
    CreateSlackNotificationJob.perform_later text: slack_message
  end

  def slack_message
    ":x: User #{@user.name} was flagged by the CSL!"
  end

  def send_email_notification
    UsersMailer.new_consolidated_screening_list_flag_email(@user).deliver_later
  end
end
