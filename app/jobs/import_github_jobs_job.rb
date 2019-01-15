class ImportGithubJobsJob < ApplicationJob
  include ActionView::Helpers::TextHelper

  queue_as :default

  def perform(*tags)
    @jobs = []

    fetch_jobs(tags)

    user = User.codefund_bot
    organization = Organization.codefund

    @jobs.each do |job|
      posting = JobPosting.github.where(source_identifier: job["id"]).first_or_initialize

      posting.user             = user
      posting.organization     = organization
      posting.company_name     = job["company"]
      posting.company_url      = job["company_url"]
      posting.company_logo_url = job["company_logo"]
      posting.job_type         = normalize_job_type(job["type"])
      posting.title            = truncate(job["title"], length: 80)
      posting.how_to_apply     = job["how_to_apply"]
      posting.description      = job["description"]
      posting.keywords         << job["tag"]
      if job["location"].downcase.include?("remote") || job["title"].downcase.include?("remote")
        posting.remote = true
        posting.keywords << "remote"
      end
      posting.city             = job["location"]
      posting.url              = job["url"]
      posting.start_date       = Chronic.parse(job["created_at"]).to_date
      posting.end_date         = posting.start_date + 60.days
      posting.source           = ENUMS::JOB_SOURCES::GITHUB
      posting.save
    end

    nil
  end

  def fetch_jobs(tags)
    hydra = Typhoeus::Hydra.new(max_concurrency: 10)

    tags.each do |tag|
      request = Typhoeus::Request.new("https://jobs.github.com/positions.json?search=#{tag}")
      request.on_complete do |response|
        JSON.parse(response.body).each { |listing| @jobs << listing.merge({ "tag" => tag }) }
      end
      hydra.queue(request)
    end

    hydra.run
  end

  def normalize_job_type(job_type)
    case job_type
    when "Full Time" then ENUMS::JOB_TYPES::FULL_TIME
    when "Part Time" then ENUMS::JOB_TYPES::PART_TIME
    when "Contract" then ENUMS::JOB_TYPES::CONTRACT
    else
      nil
    end
  end
end
