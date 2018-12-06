module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, class_name: "Event", as: :eventable
    before_destroy { |record| record.events.destroy_all }

    after_commit :track_creation, on: [:create]
  end

  module ClassMethods
    # Helper method to lookup for events for a given object.
    # This method is equivalent to obj.events
    def find_events_for(obj)
      Event.where(eventable_id: obj.id,
                  eventable_type: obj.class.base_class.name).
        order(created_at: :desc)
    end
  end

  # Helper method to sort events by date
  def events_ordered_by_submitted
    Event.where(eventable_id: id, eventable_type: self.class.name).
      order(created_at: :desc)
  end

  # Helper method that defaults the submitted time.
  def add_event(body, tags = [])
    event = Event.build_from(self, body, tags)
    event.user_id = user_id if respond_to? :user_id
    event.user_id = id if self.class == User
    events << event
  end

  private

  def track_creation
    add_event("#{self.class.base_class.name} was created", [:create])
  end
end
