# This job should be run as a failsafe... perhaps every 6-12 hours
class AssurePropertyAdvertisersJob < ApplicationJob
  queue_as :low

  def perform
    history = {}
    User.advertisers.each do |user|
      user.campaigns.each do |campaign|
        campaign.property_ids_with_impressions.each do |property_id|
          key = [property_id, user.id].join
          next if history[key]
          history[key] = true
          SetPropertyAdvertiserJob.perform_later property_id, user.id
        end
      end
    end
  end
end
