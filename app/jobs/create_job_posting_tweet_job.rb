class CreateJobPostingTweetJob < ApplicationJob
  queue_as :low

  def perform(job_posting, template)
    client = Twitter::REST::Client.new { |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY_CODE_FUND_JOBS"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET_CODE_FUND_JOBS"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN_CODE_FUND_JOBS"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET_CODE_FUND_JOBS"]
    }

    message = JobPostingsController.render(template, assigns: {job_posting: job_posting})
    client.update message
  rescue => e
    Rollbar.error e
  end
end
