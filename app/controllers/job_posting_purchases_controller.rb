class JobPostingPurchasesController < ApplicationController
  before_action :set_job_posting

  def new
    return render_forbidden unless authorized_user.can_purchase_job_posting?(@job_posting)
    return redirect_to(new_job_posting_user_path(@job_posting)) unless current_user
  end

  def create
    binding.pry
    raise NotImplementedError
    # @token = params[:token]

    # JobPosting.transaction do
    # user = current_user
    # user ||= User.find_for_authentication(email: user_params[:email])
    # user ||= User.create!(user_params)

    # if user.stripe_customer_id.present?
    # @customer = Stripe::Customer.retrieve(user.stripe_customer_id)
    # end

    # @customer ||= Stripe::Customer.create({
    # email: user.email,
    # source: @token,
    # metadata: user_params.to_h.slice(:first_name, :last_name, :company_name, :email),
    # })

    # @charge = Stripe::Charge.create({
    # amount: 29900,
    # customer: @customer.id,
    # currency: "usd",
    # description: "CodeFund Jobs Listing",
    # metadata: {"job_posting_id" => @job_posting.id},
    # })

    # unless user.persisted?
    # password = SecureRandom.hex(5)
    # user.password = password
    # user.password_confirmation = password
    # end

    # user.stripe_customer_id = @customer.id
    # user.roles << ENUMS::USER_ROLES::EMPLOYER
    # user.save!

    # @job_posting.update(
    # status: ENUMS::JOB_STATUSES::ACTIVE,
    # stripe_charge_id: @charge.id
    # )
    # end

    ## Trigger email

    # redirect_to @job_posting, notice: "Your job has been posted!"
    # rescue Stripe::CardError => e
    # flash.now[:error] = e.message
    # render :new
  end

  def show
    raise NotImplementedError
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end
end
