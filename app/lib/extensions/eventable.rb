module Extensions
  module Eventable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_eventable
        has_many :events, class_name: 'Event', as: :eventable
        before_destroy { |record| record.events.destroy_all }
        include Extensions::Eventable::LocalInstanceMethods
        extend Extensions::Eventable::SingletonMethods
      end
    end

    # This module contains class methods
    module SingletonMethods
      # Helper method to lookup for events for a given object.
      # This method is equivalent to obj.events.
      def find_events_for(obj)
        Event.where(eventable_id: obj.id,
                    eventable_type: obj.class.base_class.name)
          .order('created_at DESC')
      end
    end

    module LocalInstanceMethods
      # Helper method to sort events by date
      def events_ordered_by_submitted
        Event.where(eventable_id: id, eventable_type: self.class.name)
          .order('created_at DESC')
      end

      # Helper method that defaults the submitted time.
      def add_event(body, tags = [])
        event = Event.build_from(self, body, tags)
        event.user_id = self.user_id if self.respond_to? :user_id
        event.user_id = self.id if self.class == User
        events << event
      end
    end
  end
end