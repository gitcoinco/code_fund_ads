class CreateClickJob < ApplicationJob
  queue_as :default

  def perform(impression_id, clicked_at_string)
    impression = Impression.between(1.day.ago, Date.current).where(id: impression_id).first
    return if impression.clicked?
    clicked_at = Time.parse(clicked_at_string)
    records_saved = Impression.between(1.day.ago, Date.current).
      where(id: impression_id).
      update_all(clicked_at: clicked_at, clicked_at_date: clicked_at.to_date)
    IncrementClicksCountCacheJob.perform_now impression if records_saved > 0
  end
end
