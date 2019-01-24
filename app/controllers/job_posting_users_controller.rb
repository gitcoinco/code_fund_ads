class JobPostingUsersController < ApplicationController
  before_action :load_job_posting

  def new
    raise NotImplementedError
  end

  def create
    raise NotImplementedError
  end

  private

  def load_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :email)
  end
end
