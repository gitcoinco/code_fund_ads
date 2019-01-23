module Authorizers
  module JobPosting
    def can_update_job_posting?(job_posting, session_id)
      return true if job_posting.user_id == id
      job_posting.status == ENUMS::JOB_STATUSES::PENDING && job_posting.session_id == session_id
    end

    def can_destroy_job_posting?(job_posting)
      false
    end
  end
end
