# == Schema Information
#
# Table name: property_advertisers
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  advertiser_id :bigint           not null
#  property_id   :bigint           not null
#
# Indexes
#
#  index_property_advertisers_on_advertiser_id                  (advertiser_id)
#  index_property_advertisers_on_property_id                    (property_id)
#  index_property_advertisers_on_property_id_and_advertiser_id  (property_id,advertiser_id) UNIQUE
#

class PropertyAdvertiser < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :advertiser, class_name: "User", foreign_key: "advertiser_id"
  belongs_to :property

  # validations ...............................................................
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
