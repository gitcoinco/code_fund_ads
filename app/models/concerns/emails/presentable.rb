module Emails
  module Presentable
    extend ActiveSupport::Concern
    include ActionView::Helpers::DateHelper

    def human_delivered_at
      from_time = Time.now
      distance_of_time_in_words(from_time, delivered_at, scope: "datetime.distance_in_words.email") # => "2H"
    end
  end
end
