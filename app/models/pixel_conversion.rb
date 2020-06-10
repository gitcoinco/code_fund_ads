# == Schema Information
#
# Table name: pixel_conversions
#
#  id                   :bigint           not null, primary key
#  clicked_at           :datetime
#  clicked_at_date      :date
#  conversion_referrer  :text
#  country_code         :string
#  displayed_at         :datetime
#  displayed_at_date    :date
#  fallback_campaign    :boolean          default(FALSE), not null
#  impression_id_param  :string           default(""), not null
#  ip_address           :string
#  latitude             :decimal(, )
#  longitude            :decimal(, )
#  metadata             :jsonb            not null
#  pixel_name           :string           default(""), not null
#  pixel_value_cents    :integer          default(0), not null
#  pixel_value_currency :string           default("USD"), not null
#  postal_code          :string
#  test                 :boolean          default(FALSE), not null
#  user_agent           :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  advertiser_id        :bigint
#  campaign_id          :bigint
#  creative_id          :bigint
#  impression_id        :uuid
#  pixel_id             :uuid             not null
#  property_id          :bigint
#  publisher_id         :bigint
#
# Indexes
#
#  index_pixel_conversions_on_advertiser_id                     (advertiser_id)
#  index_pixel_conversions_on_campaign_id                       (campaign_id)
#  index_pixel_conversions_on_clicked_at_date                   (clicked_at_date)
#  index_pixel_conversions_on_country_code                      (country_code)
#  index_pixel_conversions_on_creative_id                       (creative_id)
#  index_pixel_conversions_on_displayed_at_date                 (displayed_at_date)
#  index_pixel_conversions_on_impression_id                     (impression_id)
#  index_pixel_conversions_on_metadata                          (metadata) USING gin
#  index_pixel_conversions_on_pixel_id                          (pixel_id)
#  index_pixel_conversions_on_pixel_id_and_impression_id_param  (pixel_id,impression_id_param) UNIQUE
#  index_pixel_conversions_on_property_id                       (property_id)
#
class PixelConversion < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :advertiser, class_name: "User", foreign_key: "advertiser_id", optional: true
  belongs_to :publisher, class_name: "User", foreign_key: "publisher_id", optional: true
  belongs_to :campaign, optional: true
  belongs_to :creative, optional: true
  belongs_to :impression, optional: true
  belongs_to :pixel
  belongs_to :property, optional: true

  # validations ...............................................................
  validates :impression_id_param, uniqueness: {scope: [:pixel_id], message: "already exists"}

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :pixel_value_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
