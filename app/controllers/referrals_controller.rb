class ReferralsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def new
    session[:referral_code] = params[:referral_code]
    session[:referring_user_id] ||= User.where(referral_code: params[:referral_code]).pluck(:id).first if params[:referral_code].present?

    IncrementReferralLinkClickCountJob.perform_later params[:referral_code]

    if session[:referral_code] == "opencollective"
      redirect_to page_path("partners/opencollective")
    else
      redirect_to root_path
    end
  end
end
