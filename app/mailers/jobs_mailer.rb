class JobsMailer < ApplicationMailer
  def new_job_posting_email(job_posting)
    @job_posting = job_posting
    mail(to: @job_posting.company_email, from: "jobs@codefund.io", subject: "Your job has been posted to CodeFund Jobs")
  end

  def new_code_fund_ads_job_posting_email(job_posting)
    @job_posting = job_posting
    mail(to: "team@codefund.io", from: "jobs@codefund.io", subject: "A new job with CodeFund Ads was purchased")
  end

  def new_read_the_docs_ads_job_posting_email(job_posting)
    @job_posting = job_posting
    mail(to: ENV["READ_THE_DOCS_EMAIL"], cc: "team@codefund.io", from: "jobs@codefund.io", subject: "A new job with ReadTheDocs Ads was purchased")
  end
end
