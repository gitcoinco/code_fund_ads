class SetPropertyAdvertiserJob < ApplicationJob
  queue_as :low

  def perform(property_id, advertiser_id)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f

    property = Property.find_by(id: property_id)
    return unless property

    advertiser = User.find_by(id: advertiser_id)
    return unless advertiser

    PropertyAdvertiser.where(property: property, advertiser: advertiser).first_or_create!
  end
end
