# This job should be run as a failsafe... perhaps every 24 hours
class AssurePropertyAdvertisersJob < ApplicationJob
  queue_as :low

  def perform
    User.advertisers.each do |user|
      user.campaigns.each do |campaign|
        campaign.property_ids_with_impressions(date).each do |property_id|
          SetPropertyAdvertiserJob.perform_later property_id, user.id
        end
      end
    end
  end
end
