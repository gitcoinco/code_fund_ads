# == Schema Information
#
# Table name: pixels
#
#  id              :uuid             not null, primary key
#  description     :text
#  name            :string           not null
#  value_cents     :integer          default(0), not null
#  value_currency  :string           default("USD"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_pixels_on_organization_id  (organization_id)
#  index_pixels_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
class Pixel < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :organization
  belongs_to :user
  has_many :pixel_conversions, dependent: :destroy

  # validations ...............................................................
  validates :name, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :value_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # Records an conversion for the passed impression_id
  # This operation is a noop if no impression is found
  def record_conversion(impression_id_param, conversion_referrer: nil, test: false, metadata: {})
    impression = Impression.find_by(id: impression_id_param, organization_id: organization_id) if UUID.validate(impression_id_param)
    logger.info "Pixel#record_conversion Unable to find an impression for impression_id='#{impression_id_param}' and organization_id='#{organization_id}'." unless impression
    impression_attribute_names = %w[
      advertiser_id
      campaign_id
      clicked_at
      clicked_at_date
      country_code
      creative_id
      displayed_at
      displayed_at_date
      fallback_campaign
      ip_address
      latitude
      longitude
      postal_code
      property_id
      publisher_id
      user_agent
    ]
    impression_attributes = impression&.attributes&.slice(*impression_attribute_names) || {}
    PixelConversion.where(pixel: self, impression_id_param: impression_id_param).first_or_create!(
      impression_attributes.merge(
        impression_id: impression&.id,
        conversion_referrer: conversion_referrer,
        metadata: metadata || {},
        pixel_name: name,
        pixel_value: value,
        test: test
      )
    )
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
