# == Schema Information
#
# Table name: creatives
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  name       :string           not null
#  headline   :string           not null
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Creative < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :user
  has_many :campaigns
  has_many :creative_images

  # validations ...............................................................
  validates :body, length: {maximum: 255, allow_blank: false}
  validates :headline, length: {maximum: 255, allow_blank: false}
  validates :name, length: {maximum: 255, allow_blank: false}

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def images
    user.images.where(id: creative_images.select(:active_storage_attachment_id))
  end

  def small_images
    images.search_metadata_format ENUMS::IMAGE_FORMATS::SMALL
  end

  def large_images
    images.search_metadata_format ENUMS::IMAGE_FORMATS::LARGE
  end

  def wide_images
    images.search_metadata_format ENUMS::IMAGE_FORMATS::WIDE
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
