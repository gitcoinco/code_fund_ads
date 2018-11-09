# frozen_string_literal: true
# == Schema Information
#
# Table name: impressions
#
#  id                :uuid             not null, primary key
#  campaign_id       :bigint(8)
#  property_id       :bigint(8)
#  ip                :string
#  user_agent        :text
#  country           :string
#  postal_code       :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  payable           :boolean          default(FALSE), not null
#  reason            :string
#  displayed_at      :datetime
#  displayed_at_date :date
#  clicked_at        :datetime
#  fallback_campaign :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Impression < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :campaign
  belongs_to :distribution
  belongs_to :property

  # validations ...............................................................
  validates :browser, length: { maximum: 255 }
  validates :city, length: { maximum: 255 }
  validates :country, length: { maximum: 255 }
  validates :device_type, length: { maximum: 255 }
  validates :distribution_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :ip, length: { maximum: 255, allow_blank: false }
  validates :os, length: { maximum: 255 }
  validates :postal_code, length: { maximum: 255 }
  validates :redirected_to_url, length: { maximum: 255 }
  validates :region, length: { maximum: 255 }
  validates :revenue_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: false }

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  range_partition_by :displayed_at_date

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
