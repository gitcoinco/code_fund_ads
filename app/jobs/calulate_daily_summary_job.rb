class BufferNewJobPostingJob < ApplicationJob
  queue_as :low

  def perform(record, displayed_at_date)
  end
end
