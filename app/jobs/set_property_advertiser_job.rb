class SetPropertyAdvertiserJob < ApplicationJob
  queue_as :low

  def perform(impression)
    PropertyAdvertiser.where(
      property_id: impression.property_id,
      advertiser_id: impression.advertiser_id,
      displayed_at_date: impression.displayed_at_date
    ).first_or_create!
  end
end
