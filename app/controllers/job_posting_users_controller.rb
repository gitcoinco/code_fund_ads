class JobPostingUsersController < ApplicationController
  before_action :set_job_posting

  def new
    return redirect_to(new_user_session_path(job: @job_posting.id)) if User.where(email: @job_posting.company_email).exists?
    @user = User.new(
      email: @job_posting.company_email,
      company_name: @job_posting.company_name
    )
  end

  def create
    return redirect_to(new_job_posting_purchase_path(@job_posting)) if User.find_by(email: @job_posting.company_email)
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      @job_posting.update! user: @user
      session[:job_posting_prospect_id] = @job_posting.id
      redirect_to new_job_posting_purchase_path(@job_posting), notice: "Your account was successfully created."
    else
      render :new
    end
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :email)
      .tap do |whitelisted|
        whitelisted[:password] = SecureRandom.hex[0, 8].upcase
        whitelisted[:password_confirmation] = whitelisted[:password]
        whitelisted[:confirmed_at] = Time.current
        whitelisted[:roles] = [ENUMS::USER_ROLES::EMPLOYER]
      end
  end
end
