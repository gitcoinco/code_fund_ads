class SetPropertyAdvertiserJob < ApplicationJob
  queue_as :low

  def perform(property_id, advertiser_id)
    PropertyAdvertiser.where(property_id: property_id, advertiser_id: advertiser_id).first_or_create!
  end
end
