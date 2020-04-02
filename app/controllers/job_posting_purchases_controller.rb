class JobPostingPurchasesController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :set_job_posting
  before_action :set_prices, only: [:new, :create]

  def new
    redirect_to(new_job_posting_user_path(@job_posting)) unless current_user
  end

  def create
    return render_forbidden unless authorized_user.can_purchase_job_posting?(@job_posting)

    if params[:source_id].blank?
      flash.now[:error] = "Payment info not submitted! Please try again."
      return render(:new)
    end

    amount = 0
    case job_posting_params[:plan]
    when "monthly" then amount = @monthly_plan_price.cents
    when "prepaid" then amount = @prepaid_plan_price.cents
    else
      flash.now[:error] = "Unknown plan! Please try again."
      return render(:new)
    end
    amount += @premium_placement_offer_price.cents if job_posting_params[:offers].include?("premium_placement")
    amount += @code_fund_ads_offer_price.cents if job_posting_params[:offers].include?("code_fund_ads")
    amount += @read_the_docs_offer_price.cents if job_posting_params[:offers].include?("read_the_docs_ads")

    charge = current_user.create_stripe_charge!(
      source_id: params[:source_id],
      amount: amount,
      currency: "usd",
      description: "CodeFund Jobs Listing",
      metadata: {job_posting_id: @job_posting.id}
    )

    @job_posting.update!(
      plan: job_posting_params[:plan],
      offers: job_posting_params[:offers] || [],
      status: ENUMS::JOB_STATUSES::ACTIVE,
      stripe_charge_id: charge.id,
      coupon_id: @coupon&.id
    )

    begin
      @coupon&.increment!(:claimed)
      session[:coupon_id] = nil

      # Send Email and slack notifications
      JobsMailer.new_job_posting_email(@job_posting).deliver_later
      JobsMailer.new_code_fund_ads_job_posting_email(@job_posting).deliver_later if @job_posting.code_fund_ads?
      JobsMailer.new_read_the_docs_ads_job_posting_email(@job_posting).deliver_later if @job_posting.read_the_docs_ads?
      CreateSlackNotificationJob.perform_later text: "<!channel> :party-parrot: New job posting (#{@job_posting.plan} #{@job_posting.offers.join ", "}): #{job_posting_url(@job_posting)}"
    rescue => e
      logger.error "JobPostingPurchasesController#create notifications failed! #{e}"
      Rollbar.error e
    end

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
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, session.id)
    render partial: "/job_posting_purchases/coupon_form",
           locals: {job_posting: @job_posting},
           layout: false
  end

  def update
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, session.id)
    coupon = Coupon.find_by(code: params[:coupon_code])
    if coupon&.active?
      session[:coupon_id] = coupon.id
      redirect_to new_job_posting_purchase_path(@job_posting), notice: "Your discount has been applied"
    else
      redirect_to new_job_posting_purchase_path(@job_posting), alert: "The coupon you applied is no longer available"
    end
  end

  private

  def job_posting_params
    params.require(:job_posting).permit(:plan, offers: [])
  end

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end

  def set_prices
    @monthly_plan_price = Monetize.parse(ENV.fetch("JOBS_MONTHLY_PLAN_PRICE", "$299.00 USD"))
    @prepaid_plan_price = Monetize.parse(ENV.fetch("JOBS_PREPAID_PLAN_PRICE", "$199.00 USD")) * 3
    @premium_placement_offer_price = Monetize.parse("$99.00 USD")
    @code_fund_ads_offer_price = Monetize.parse("$199.00 USD")
    @read_the_docs_offer_price = Monetize.parse("$299.00 USD")
    apply_coupon
  end

  def apply_coupon
    return unless session[:coupon_id]
    @coupon = Coupon.find_by(id: session[:coupon_id])
    return unless @coupon
    @monthly_plan_price = @coupon.apply_discount(@monthly_plan_price)
    @prepaid_plan_price = @coupon.apply_discount(@prepaid_plan_price)

    if @coupon.percentage?
      @premium_placement_offer_price = @coupon.apply_discount(@premium_placement_offer_price)
      @code_fund_ads_offer_price = @coupon.apply_discount(@code_fund_ads_offer_price)
      @read_the_docs_offer_price = @coupon.apply_discount(@read_the_docs_offer_price)
    end
  end
end
