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
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.advertisers.search_name(value).or(User.advertisers.search_company(value))) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  attr_accessor :small_image, :large_image, :wide_image

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def images
    user.images.where(id: creative_images.select(:active_storage_attachment_id))
  end

  def small_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::SMALL).first
  end

  def large_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::LARGE).first
  end

  def wide_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::WIDE).first
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
