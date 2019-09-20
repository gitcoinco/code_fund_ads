class CreateEventJob < ApplicationJob
  queue_as :default

  def perform(sgid, body, tags = [])
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    eventable = GlobalID::Locator.locate_signed(sgid)
    return unless eventable
    event = Event.build_from(eventable, body, tags)
    event.user_id = eventable.user_id if eventable.respond_to? :user_id
    event.user_id = eventable.id if eventable.class == User
    eventable.events << event
  end
end
