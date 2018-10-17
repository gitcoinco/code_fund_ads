# == Schema Information
#
# Table name: campaigns
#
#  id                             :uuid             not null, primary key
#  name                           :string(255)      not null
#  redirect_url                   :text             not null
#  status                         :integer          default(0), not null
#  ecpm                           :decimal(10, 2)   not null
#  budget_daily_amount            :decimal(10, 2)   not null
#  total_spend                    :decimal(10, 2)   not null
#  user_id                        :uuid
#  inserted_at                    :datetime         not null
#  updated_at                     :datetime         not null
#  audience_id                    :uuid
#  creative_id                    :uuid
#  included_countries             :string(255)      default([]), is an Array
#  impression_count               :integer          default(0), not null
#  start_date                     :datetime
#  end_date                       :datetime
#  us_hours_only                  :boolean          default(FALSE)
#  weekdays_only                  :boolean          default(FALSE)
#  included_programming_languages :string(255)      default([]), is an Array
#  included_topic_categories      :string(255)      default([]), is an Array
#  excluded_programming_languages :string(255)      default([]), is an Array
#  excluded_topic_categories      :string(255)      default([]), is an Array
#  fallback_campaign              :boolean          default(FALSE), not null
#

class Campaign < ApplicationRecord
  STATUSES = {
    pending: 1,
    active: 2,
    archived: 3
  }.freeze

  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :creative
  belongs_to :user

  # validations ...............................................................
  validates :budget_daily_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :ecpm, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :fallback_campaign, presence: true
  validates :impression_count, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :name, length: { maximum: 255, allow_blank: false }
  validates :redirect_url, presence: true
  validates :status, inclusion: { in: STATUSES.values }
  validates :total_spend, numericality: { greater_than_or_equal_to: 0, allow_nil: false }

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
