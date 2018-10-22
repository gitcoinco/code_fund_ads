# frozen_string_literal: true

# == Schema Information
#
# Table name: impressions
#
#  id                  :uuid             not null, primary key
#  ip                  :string(255)      not null
#  user_agent          :text
#  browser             :string(255)
#  os                  :string(255)
#  device_type         :string(255)
#  country             :string(255)
#  region              :string(255)
#  city                :string(255)
#  postal_code         :string(255)
#  latitude            :decimal(, )
#  longitude           :decimal(, )
#  property_id         :uuid
#  campaign_id         :uuid
#  inserted_at         :datetime         not null
#  updated_at          :datetime         not null
#  redirected_at       :datetime
#  redirected_to_url   :string(255)
#  revenue_amount      :decimal(13, 12)  default(0.0), not null
#  distribution_amount :decimal(13, 12)  default(0.0), not null
#  distribution_id     :uuid
#  browser_height      :integer
#  browser_width       :integer
#  error_code          :integer
#  house_ad            :boolean          default(FALSE)
#

class Impression < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :campaign
  belongs_to :distribution
  belongs_to :property

  # validations ...............................................................
  validates :browser, length: {maximum: 255}
  validates :city, length: {maximum: 255}
  validates :country, length: {maximum: 255}
  validates :device_type, length: {maximum: 255}
  validates :distribution_amount, numericality: {greater_than_or_equal_to: 0, allow_nil: false}
  validates :ip, length: {maximum: 255, allow_blank: false}
  validates :os, length: {maximum: 255}
  validates :postal_code, length: {maximum: 255}
  validates :redirected_to_url, length: {maximum: 255}
  validates :region, length: {maximum: 255}
  validates :revenue_amount, numericality: {greater_than_or_equal_to: 0, allow_nil: false}

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
