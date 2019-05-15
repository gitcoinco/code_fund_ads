# == Schema Information
#
# Table name: creatives
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  name            :string           not null
#  headline        :string           not null
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint
#  cta             :string
#

class Creative < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Eventable
  include Organizationable
  include Sanitizable
  include Creatives::Presentable

  # relationships .............................................................
  belongs_to :user
  belongs_to :organization
  has_many :campaigns
  has_many :creative_images

  # validations ...............................................................
  validates :body, length: {maximum: 255, allow_blank: false}
  validates :headline, length: {maximum: 255, allow_blank: false}
  validates :cta, length: {maximum: 20, allow_blank: false}
  validates :name, length: {maximum: 255, allow_blank: false}

  # callbacks .................................................................
  after_commit :touch_campaigns, on: [:update]

  # scopes ....................................................................
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.advertisers.search_name(value).or(User.advertisers.search_company(value))) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  sanitize :headline, :body, :cta

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def images
    user.images.where(id: creative_images.select(:active_storage_attachment_id))
  end

  def add_image!(image)
    CreativeImage.create! creative: self, image: image
  end

  def assign_images(blob_id_list = {})
    assign_icon_image(blob_id_list[:icon_blob_id]) if blob_id_list[:icon_blob_id].present?
    assign_small_image(blob_id_list[:small_blob_id]) if blob_id_list[:small_blob_id].present?
    assign_large_image(blob_id_list[:large_blob_id]) if blob_id_list[:large_blob_id].present?
    assign_wide_image(blob_id_list[:wide_blob_id]) if blob_id_list[:wide_blob_id].present?
  end

  def icon_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::ICON).first
  end

  def assign_icon_image(blob_id)
    creative_image = creative_images.icon.first_or_initialize
    image = user.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def small_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::SMALL).first
  end

  def assign_small_image(blob_id)
    creative_image = creative_images.small.first_or_initialize
    image = user.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def large_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::LARGE).first
  end

  def assign_large_image(blob_id)
    creative_image = creative_images.large.first_or_initialize
    image = user.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def wide_image
    images.search_metadata_format(ENUMS::IMAGE_FORMATS::WIDE).first
  end

  def assign_wide_image(blob_id)
    creative_image = creative_images.wide.first_or_initialize
    image = user.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def touch_campaigns
    campaigns.map(&:touch)
  end
end
