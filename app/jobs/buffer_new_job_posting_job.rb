class BufferNewJobPostingJob < ApplicationJob
  queue_as :low

  def perform(job_posting, template)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    return unless ENV["BUFFER_ENABLED"] == "true"

    client = Buffer::Client.new ENV["BUFFER_ACCESS_TOKEN"]
    message = JobPostingsController.render(template, assigns: {job_posting: job_posting})
    client.create_update(
      body: {
        text: message,
        profile_ids: [ENV["BUFFER_PROFILE_ID"]],
        now: true, # Set to false if you want to buffer the tweets instead
        media: {
          picture: job_posting.company_logo_url,
          link: "https://codefund.io/jobs/directory/#{job_posting.id}",
          title: "#{job_posting.company_name} is hiring",
          description: job_posting.title,
        },
      }
    )
  rescue => e
    Rollbar.error e
  end
end
