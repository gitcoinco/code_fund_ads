# This job should be run as a failsafe... perhaps every 6-12 hours
class AssurePropertyAdvertisersJob < ApplicationJob
  queue_as :low

  def perform
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    history = {}
    User.advertisers.each do |user|
      user.campaigns.each do |campaign|
        campaign.properties.pluck(:id).each do |property_id|
          key = [property_id, user.id].join
          next if history[key]
          history[key] = true
          SetPropertyAdvertiserJob.perform_later property_id, user.id
        end
      end
    end
  end
end
