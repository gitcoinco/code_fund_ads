class RecordUpliftJob < ApplicationJob
  queue_as :low

  def perform(advertiser_id, impression_id)
    Impression
      .partitioned(advertiser_id, 2.days.ago, Date.current)
      .where(id: impression_id)
      .update_all(uplift: true)
  end
end
