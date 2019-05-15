# == Schema Information
#
# Table name: creative_images
#
#  id                           :bigint           not null, primary key
#  creative_id                  :bigint           not null
#  active_storage_attachment_id :bigint           not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class CreativeImage < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :creative
  belongs_to :image, class_name: "ActiveStorage::Attachment", foreign_key: "active_storage_attachment_id"

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  scope :icon, -> { where active_storage_attachment_id: ActiveStorage::Attachment.search_metadata_format(ENUMS::IMAGE_FORMATS::ICON) }
  scope :small, -> { where active_storage_attachment_id: ActiveStorage::Attachment.search_metadata_format(ENUMS::IMAGE_FORMATS::SMALL) }
  scope :large, -> { where active_storage_attachment_id: ActiveStorage::Attachment.search_metadata_format(ENUMS::IMAGE_FORMATS::LARGE) }
  scope :wide, -> { where active_storage_attachment_id: ActiveStorage::Attachment.search_metadata_format(ENUMS::IMAGE_FORMATS::WIDE) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
