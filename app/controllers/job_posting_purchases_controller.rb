class JobPostingPurchasesController < ApplicationController
  before_action :set_job_posting

  def new
    return redirect_to(new_job_posting_user_path(@job_posting)) unless current_user
    @price = Monetize.parse("$299.00 USD")
    if session[:coupon_id].present?
      @coupon = Coupon.find_by(id: session[:coupon_id])
      @price = @coupon.apply_discount(@price) if @coupon
    end
  end

  def create
    return render_forbidden unless authorized_user.can_purchase_job_posting?(@job_posting)

    if params[:source_id].blank?
      flash.now[:error] = "Payment info not submitted! Please try again."
      return render(:new)
    end

    @price = Monetize.parse("$299.00 USD")
    if session[:coupon_id].present?
      @coupon = Coupon.find_by(id: session[:coupon_id])
      @price = @coupon.apply_discount(@price) if @coupon
    end

    charge = current_user.create_stripe_charge!(
      source_id: params[:source_id],
      amount: @price.cents,
      currency: "usd",
      description: "CodeFund Jobs Listing",
      metadata: {job_posting_id: @job_posting.id},
    )

    @job_posting.update!(
      status: ENUMS::JOB_STATUSES::ACTIVE,
      stripe_charge_id: charge.id,
      coupon_id: @coupon&.id
    )

    @coupon&.increment!(:claimed)

    # Send Email and slack notifications
    JobsMailer.new_job_posting_email(@job_posting).deliver_later
    CreateSlackNotificationJob.perform_later text: "<!channel> :party-parrot: New job posting: #{job_posting_url(@job_posting)}"

    session[:coupon_id] = nil

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

  def edit
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting)
    render partial: "/job_posting_purchases/coupon_form",
           locals: {job_posting: @job_posting},
           layout: false
  end

  def update
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting)
    coupon = Coupon.find_by(code: params[:coupon_code])
    if coupon&.active?
      session[:coupon_id] = coupon.id
      redirect_to new_job_posting_purchase_path(@job_posting), notice: "Your discount has been applied"
    else
      redirect_to new_job_posting_purchase_path(@job_posting), alert: "The coupon you applied is no longer available"
    end
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end
end
