# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  body           :text             not null
#  eventable_type :string           not null
#  tags           :string           default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  eventable_id   :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_events_on_eventable_id_and_eventable_type  (eventable_id,eventable_type)
#  index_events_on_user_id                          (user_id)
#

class Event < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  belongs_to :eventable, polymorphic: true
  belongs_to :user

  # validations ...............................................................
  validates :body, presence: true
  validates :user, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # Helper class method to lookup all events assigned
  # to all eventable types for a given user.
  scope :by_user, ->(user) { where(user_id: user.id).order("created_at DESC") }

  # Helper class method to look up all events for
  # eventable class name and eventable id.
  scope :for_eventable, ->(eventable_str, eventable_id) do
    where(eventable_type: eventable_str.to_s, eventable_id: eventable_id).order("created_at DESC")
  end

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_tags
  # - without_tags
  # - with_any_tags
  # - without_any_tags
  # - with_all_tags
  # - without_all_tags
  #
  # Examples
  #
  #   irb>User.events.with_tags("registration", "email")

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :tags

  # class methods .............................................................
  class << self
    # Helper class method that allows you to build an event
    # by passing a eventable object, body text and tags
    def build_from(obj, body, tags = [])
      new(eventable: obj, body: body, tags: tags)
    end

    # Helper class method to look up an eventable object
    # given the eventable class name and id
    def find_eventable(eventable_str, eventable_id)
      eventable_str.constantize.find(eventable_id)
    end
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
