class CreateClickJob < ApplicationJob
  queue_as :default

  def perform(impression_id, clicked_at_string)
    impression = Impression.find(impression_id)
    return if impression.clicked?
    impression.update_columns clicked_at: Time.parse(clicked_at_string)
    IncrementClicksCountCacheJob.perform_now impression
  end
end
