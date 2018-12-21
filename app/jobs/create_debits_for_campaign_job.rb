class CreateDebitsForCampaignJob < ApplicationJob
  queue_as :critical

  def perform
    (10.days.ago.to_date..1.day.ago.to_date).each do |date|
      Campaign.select(:id).available_on(date).find_each do |campaign|
        CreateDebitForCampaignAndDateJob.perform_later campaign.id, date.iso8601
      end
    end
  end
end
