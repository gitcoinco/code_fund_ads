class PurchaseJobPostingsController < ApplicationController
  before_action :load_job_posting

  def new
    @user = User.new(
      email: @job_posting.company_email,
      company_name: @job_posting.company_name
    )
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def load_job_posting
    @job_posting = JobPosting.find(params[:id])
  end
end
