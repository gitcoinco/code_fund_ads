module Authorizers
  module JobPosting
    def can_update_job_posting?(job_posting, session_id)
      return false unless job_posting
      return true if job_posting.user_id == id
      job_posting.status == ENUMS::JOB_STATUSES::PENDING && session_id && job_posting.session_id == session_id
    end

    def can_destroy_job_posting?(job_posting)
      false
    end

    def can_purchase_job_posting?(job_posting)
      return false if new_record?
      return false unless job_posting
      job_posting.user_id == id
    end
  end
end
