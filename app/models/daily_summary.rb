# == Schema Information
#
# Table name: daily_summaries
#
#  id                                  :bigint(8)        not null, primary key
#  impressionable_type                 :string           not null
#  impressionable_id                   :bigint(8)        not null
#  impressions_count                   :integer          default(0), not null
#  clicks_count                        :integer          default(0), not null
#  average_ecpm_cents                  :integer          default(0), not null
#  average_ecpm_currency               :string           default("USD"), not null
#  estimated_gross_revenue_cents       :integer          default(0), not null
#  estimated_gross_revenue_currency    :string           default("USD"), not null
#  estimated_property_revenue_cents    :integer          default(0), not null
#  estimated_property_revenue_currency :string           default("USD"), not null
#  estimated_house_revenue_cents       :integer          default(0), not null
#  estimated_house_revenue_currency    :string           default("USD"), not null
#  displayed_at_date                   :date             not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#

class DailySummary < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :record, polymorphic: true

  # validations ...............................................................
  validates :count, presence: true
  validates :displayed_at_date, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
