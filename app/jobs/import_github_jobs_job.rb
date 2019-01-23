class ImportGithubJobsJob < ApplicationJob
  include ActionView::Helpers::TextHelper

  queue_as :default

  def perform(*tags)
    @count = 0
    tags.in_groups_of(5, false).each do |tag_group|
      import_jobs(tag_group)
      print tag_group.join(", ")
      sleep 3
    end
  end

  def import_jobs(tags)
    @jobs = []

    fetch_jobs(tags)

    user = User.codefund_bot
    organization = Organization.codefund
    keyword_aliases = ENUMS::KEYWORDS.values.flatten.map(&:downcase).uniq
    sieve = Stopwords::Snowball::WordSieve.new

    @jobs.each do |job|
      words = sieve.filter(lang: :en, words: "#{job["title"]} #{job["description"]} #{job["tag"]}".downcase.gsub(/,|\.\s/, "").split)
      matching_keyword_aliases = keyword_aliases & words

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
      if job["location"].downcase.include?("remote") || job["title"].downcase.include?("remote")
        posting.remote = true
      end
      posting.keywords         = normalize_keywords(matching_keyword_aliases)
      city, province_abbr      = parse_location(job["location"])
      province                 = Province.find("US-#{province_abbr}")

      posting.city             = city
      posting.province_code    = province&.iso_code
      posting.country_code     = province&.country_code
      posting.url              = job["url"]
      posting.start_date       = Chronic.parse(job["created_at"]).to_date
      posting.end_date         = posting.start_date + 60.days
      posting.status           = posting.start_date <= 60.days.ago ? ENUMS::JOB_STATUSES::ACTIVE : ENUMS::JOB_STATUSES::ARCHIVED
      posting.source           = ENUMS::JOB_SOURCES::GITHUB
      posting.save
      print "#{@count += 1},"
    end

    nil
  end

  def parse_location(location)
    parts = location.to_s.split(",").map { |part| part.strip }.select(&:present?)
    return [parts.join(" "), nil] unless parts.size == 2
    return [parts.first, nil] unless parts.last.size == 2
    [parts.first, parts.last.upcase]
  end

  def fetch_jobs(tags)
    hydra = Typhoeus::Hydra.new(max_concurrency: 5)
    headers = {"Content-Type" => "application/json"}

    tags.each do |tag|
      url = "https://jobs.github.com/positions.json"
      request = Typhoeus::Request.new(url, headers: headers, params: {search: tag})
      request.on_complete do |response|
        JSON.parse(response.body).each { |listing| @jobs << listing.merge({"tag" => tag}) }
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
    end
  end

  def normalize_keywords(tags)
    keywords = []

    tags.each do |tag|
      ENUMS::KEYWORDS.keys.each do |key|
        if ENUMS::KEYWORDS[key].include?(tag)
          keywords << key
        elsif tag == key
          keywords << key
        end
      end
    end

    keywords.uniq.compact.sort
  end
end
