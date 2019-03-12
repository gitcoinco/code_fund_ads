class CreateDailySummariesJob < ApplicationJob
  queue_as :low

  def perform(impressionable, start_date_string, end_date_string, scoped_by)
    start_date = Date.coerce(start_date_string)
    end_date = Date.coerce(end_date_string)
    (start_date..end_date).each do |date|
      next if date.today? || date.future?
      next if impressionable.daily_summaries.on(date).scoped_by(scoped_by).exists?
      CreateDailySummaryJob.perform_later impressionable, date.iso8601, scoped_by
    end
  end
end
