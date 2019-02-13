class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(user)
    if params[:job].present?
      job_posting = JobPosting.find_by(id: params[:job], session_id: session.id)
      return new_job_posting_purchase_path(job_posting) if job_posting&.pending?
    end
    helpers.default_dashboard_path(user)
  end

  def after_sign_out_path_for(_user)
    new_user_session_path
  end
end
