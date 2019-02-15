class SetPropertyAdvertiserJob < ApplicationJob
  queue_as :low

  def perform(property_id, advertiser_id)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    PropertyAdvertiser.where(property_id: property_id, advertiser_id: advertiser_id).first_or_create!
  end
end
