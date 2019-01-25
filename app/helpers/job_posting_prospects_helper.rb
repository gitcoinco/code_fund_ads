module JobPostingProspectsHelper
  def job_posting_prospects_form_path(job_posting)
    return job_posting_prospect_path(job_posting) if job_posting.persisted?
    job_posting_prospects_path
  end
end
