class JobPostingPurchasesController < ApplicationController
  before_action :set_job_posting

  def new
    return redirect_to(new_job_posting_user_path(@job_posting)) unless current_user
  end

  def create
    return render_forbidden unless authorized_user.can_purchase_job_posting?(@job_posting)

    if params[:source_id].blank?
      flash.now[:error] = "Payment info not submitted! Please try again."
      return render(:new)
    end

    charge = current_user.create_stripe_charge!(
      source_id: params[:source_id],
      amount: Monetize.parse("$299.00 USD").cents,
      currency: "usd",
      description: "CodeFund Jobs Listing",
      metadata: {job_posting_id: @job_posting.id},
    )

    @job_posting.update!(
      status: ENUMS::JOB_STATUSES::ACTIVE,
      stripe_charge_id: charge.id
    )

    # Send Email and slack notifications
    JobsMailer.new_job_posting_email(@job_posting).deliver_later
    CreateSlackNotificationJob.perform_later text: "<!channel> :party-parrot: New job posting: #{job_posting_url(@job_posting)}"

    redirect_to job_posting_purchase_path(@job_posting), notice: "Congratulations! Your job has been posted."
  rescue Stripe::CardError => e
    flash.now[:error] = e.message
    render :new
  rescue => e
    logger.error "JobPostingPurchasesController#create #{e}"
    Rollbar.error e, action: "JobPostingPurchasesController#create", user_id: current_user.id, job_posting_id: @job_posting.id
    flash.now[:error] = "An unexpected error has occurred! Our team has been notified and will be working to remedy the problem."
    render :new
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end
end
