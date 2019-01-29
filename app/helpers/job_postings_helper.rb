module JobPostingsHelper
  def job_posting_status_color(status)
    ENUMS::JOB_STATUS_COLORS[status]
  end
end
