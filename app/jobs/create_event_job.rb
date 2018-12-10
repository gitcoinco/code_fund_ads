class CreateEventJob < ApplicationJob
  queue_as :default

  def perform(sgid, body, tags = [])
    eventable = GlobalID::Locator.locate_signed(params[:sgid])
    event = Event.build_from(eventable, body, tags)
    event.user_id = user_id if respond_to? :user_id
    event.user_id = id if eventable.class == User
    eventable.events << event
  end
end
