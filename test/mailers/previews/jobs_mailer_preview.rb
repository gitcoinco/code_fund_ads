class JobsMailerPreview < ActionMailer::Preview
  def new_job_posting_email
    job_posting = JobPosting.new(
      id: 1,
      title: "Full Stack Developer",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      keywords: %w[JavaScript VueJS],
      min_annual_salary_cents: Monetize.parse("$75,000 USD").cents,
      min_annual_salary_currency: "USD",
      max_annual_salary_cents: Monetize.parse("$95,000 USD").cents,
      max_annual_salary_currency: "USD",
      remote: true,
      remote_country_codes: "US",
      start_date: Date.today,
      end_date: Date.today + 30.days,
      company_email: "test@example.com"
    )
    JobsMailer.new_job_posting_email(job_posting)
  end

  def new_code_fund_ads_job_posting_email
    job_posting = JobPosting.new(
      id: 1,
      title: "Full Stack Developer",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      keywords: %w[JavaScript VueJS],
      min_annual_salary_cents: Monetize.parse("$75,000 USD").cents,
      min_annual_salary_currency: "USD",
      max_annual_salary_cents: Monetize.parse("$95,000 USD").cents,
      max_annual_salary_currency: "USD",
      remote: true,
      remote_country_codes: "US",
      start_date: Date.today,
      end_date: Date.today + 30.days,
      company_email: "test@example.com"
    )
    JobsMailer.new_code_fund_ads_job_posting_email(job_posting)
  end

  def new_read_the_docs_ads_job_posting_email
    job_posting = JobPosting.new(
      id: 1,
      title: "Full Stack Developer",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      keywords: %w[JavaScript VueJS],
      min_annual_salary_cents: Monetize.parse("$75,000 USD").cents,
      min_annual_salary_currency: "USD",
      max_annual_salary_cents: Monetize.parse("$95,000 USD").cents,
      max_annual_salary_currency: "USD",
      remote: true,
      remote_country_codes: "US",
      start_date: Date.today,
      end_date: Date.today + 30.days,
      company_email: "test@example.com"
    )
    JobsMailer.new_read_the_docs_ads_job_posting_email(job_posting)
  end
end
