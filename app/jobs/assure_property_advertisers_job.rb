# This job should be run as a failsafe... perhaps every 24 hours
class AssurePropertyAdvertisersJob < ApplicationJob
  queue_as :low

  def perform
    User.advertisers.each do |user|
      user.campaigns.each do |campaign|
        campaign.dates_with_impressions.each do |date|
          campaign.property_ids_with_impressions(date).each do |property_id|
            PropertyAdvertiser.where(
              property_id: property_id,
              advertiser_id: user.id,
              displayed_at_date: date
            ).first_or_create!
          end
        end
      end
    end
  end
end
