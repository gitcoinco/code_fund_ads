class JobsMailer < ApplicationMailer
  before_action :set_inline_attachments
  layout "mailer"

  def new_job_posting_email(job_posting)
    @job_posting = job_posting
    mail(to: @job_posting.company_email, from: "jobs@codefund.io", subject: "Your job has been posted to CodeFund Jobs")
  end
end
