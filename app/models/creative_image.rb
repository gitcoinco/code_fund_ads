# == Schema Information
#
# Table name: creative_images
#
#  id                           :bigint           not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  active_storage_attachment_id :bigint           not null
#  creative_id                  :bigint           not null
#
# Indexes
#
#  index_creative_images_on_active_storage_attachment_id  (active_storage_attachment_id)
#  index_creative_images_on_creative_id                   (creative_id)
#

class CreativeImage < ApplicationRecord
  STANDARD_FORMATS = [
    ENUMS::IMAGE_FORMATS::ICON,
    ENUMS::IMAGE_FORMATS::SMALL,
    ENUMS::IMAGE_FORMATS::LARGE,
    ENUMS::IMAGE_FORMATS::WIDE
  ].freeze

  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :creative
  belongs_to :image, class_name: "ActiveStorage::Attachment", foreign_key: "active_storage_attachment_id"

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  scope :icon, -> { where active_storage_attachment_id: ActiveStorage::Attachment.metadata_format(ENUMS::IMAGE_FORMATS::ICON) }
  scope :small, -> { where active_storage_attachment_id: ActiveStorage::Attachment.metadata_format(ENUMS::IMAGE_FORMATS::SMALL) }
  scope :large, -> { where active_storage_attachment_id: ActiveStorage::Attachment.metadata_format(ENUMS::IMAGE_FORMATS::LARGE) }
  scope :wide, -> { where active_storage_attachment_id: ActiveStorage::Attachment.metadata_format(ENUMS::IMAGE_FORMATS::WIDE) }
  scope :standard, -> { where active_storage_attachment_id: ActiveStorage::Attachment.metadata_format(STANDARD_FORMATS) }
  scope :sponsor, -> { where active_storage_attachment_id: ActiveStorage::Attachment.metadata_format(ENUMS::IMAGE_FORMATS::SPONSOR) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  delegate :organization, to: :creative

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def standard?
    STANDARD_FORMATS.include? image.metadata[:format]
  end

  def sponsor?
    image.metadata[:format] == ENUMS::IMAGE_FORMATS::SPONSOR
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
