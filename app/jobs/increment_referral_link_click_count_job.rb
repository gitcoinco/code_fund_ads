class IncrementReferralLinkClickCountJob < ApplicationJob
  queue_as :low

  def perform(referral_code)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    user = User.find_by(referral_code: referral_code)
    user&.increment! :referral_click_count
  end
end
