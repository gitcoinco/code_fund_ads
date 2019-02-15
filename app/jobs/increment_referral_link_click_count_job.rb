class IncrementReferralLinkClickCountJob < ApplicationJob
  queue_as :low

  def perform(referral_code)
    user = User.find_by(referral_code: referral_code)
    user&.increment! :referral_click_count
  end
end
