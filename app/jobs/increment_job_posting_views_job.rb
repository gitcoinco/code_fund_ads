class IncrementJobPostingViewsJob < ApplicationJob
  queue_as :low

  def perform(job_posting_id, column_name)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    job_posting = JobPosting.find_by(id: job_posting_id)
    job_posting&.increment! column_name
  end
end
