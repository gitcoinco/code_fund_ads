# == Schema Information
#
# Table name: creatives
#
#  id              :bigint           not null, primary key
#  body            :text
#  creative_type   :string           default("standard"), not null
#  cta             :string
#  headline        :string
#  name            :string           not null
#  status          :string           default("pending")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_creatives_on_creative_type    (creative_type)
#  index_creatives_on_organization_id  (organization_id)
#  index_creatives_on_user_id          (user_id)
#

class Creative < ApplicationRecord
  MAX_AD_COPY_LENGTH = 85

  # extends ...................................................................
  # includes ..................................................................
  include Eventable
  include Organizationable
  include Sanitizable
  include SplitTestable
  include Creatives::Presentable

  # relationships .............................................................
  belongs_to :user
  belongs_to :organization
  has_many :campaigns
  has_many :creative_images
  has_many :images, through: :creative_images
  has_many :pixel_conversions
  has_many :standard_images, -> { metadata_format CreativeImage::STANDARD_FORMATS }, through: :creative_images, source: :image

  # validations ...............................................................
  validates :body, length: {maximum: 255, allow_blank: false}, if: :standard?
  validates :headline, length: {maximum: 255, allow_blank: false}, if: :standard?
  validates :cta, length: {maximum: 20, allow_blank: false}, if: :standard?
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :status, inclusion: {in: ENUMS::CREATIVE_STATUSES.values}
  validates :creative_type, inclusion: {in: ENUMS::CREATIVE_TYPES.values}
  validate :validate_status_change
  validate :validate_ad_copy_length

  # callbacks .................................................................
  after_commit :touch_campaigns, on: [:update]
  before_destroy :validate_destroyable

  # scopes ....................................................................
  scope :active, -> { where(status: ENUMS::CREATIVE_STATUSES::ACTIVE) }
  scope :pending, -> { where(status: ENUMS::CREATIVE_STATUSES::PENDING) }
  scope :archived, -> { where(status: ENUMS::CREATIVE_STATUSES::ARCHIVED) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.advertisers.search_name(value).or(User.advertisers.search_company(value))) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }
  scope :standard, -> { where creative_type: ENUMS::CREATIVE_TYPES::STANDARD }
  scope :sponsor, -> { where creative_type: ENUMS::CREATIVE_TYPES::SPONSOR }
  scope :order_by_status, -> {
                            order_by = ["CASE"]
                            ENUMS::CREATIVE_STATUSES.values.each_with_index do |status, index|
                              order_by << "WHEN status='#{status}' THEN #{index}"
                            end
                            order_by << "END"
                            order(Arel.sql(order_by.join(" ")))
                          }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  sanitize :headline, :body, :cta
  attr_writer :cloned_images

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def standard?
    creative_type == ENUMS::CREATIVE_TYPES::STANDARD
  end

  def sponsor?
    creative_type == ENUMS::CREATIVE_TYPES::SPONSOR
  end

  def active?
    status == ENUMS::CREATIVE_STATUSES::ACTIVE
  end

  def pending?
    status == ENUMS::CREATIVE_STATUSES::PENDING
  end

  def archived?
    status == ENUMS::CREATIVE_STATUSES::ARCHIVED
  end

  def add_image!(image)
    CreativeImage.create! creative: self, image: image
  end

  def assign_images(params = {})
    assign_icon_image(params[:icon_blob_id]) if params[:icon_blob_id].present?
    assign_small_image(params[:small_blob_id]) if params[:small_blob_id].present?
    assign_large_image(params[:large_blob_id]) if params[:large_blob_id].present?
    assign_wide_image(params[:wide_blob_id]) if params[:wide_blob_id].present?
    assign_sponsor_image(params[:sponsor_blob_id]) if params[:sponsor_blob_id].present?
  end

  def icon_image
    return images.metadata_format(ENUMS::IMAGE_FORMATS::ICON).first unless images.loaded?
    images.find { |image| image.blob.metadata["format"] == ENUMS::IMAGE_FORMATS::ICON }
  end

  def assign_icon_image(blob_id)
    creative_image = creative_images.icon.first_or_initialize
    image = organization.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def small_image
    return images.metadata_format(ENUMS::IMAGE_FORMATS::SMALL).first unless images.loaded?
    images.find { |image| image.blob.metadata["format"] == ENUMS::IMAGE_FORMATS::SMALL }
  end

  def assign_small_image(blob_id)
    creative_image = creative_images.small.first_or_initialize
    image = organization.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def large_image
    return images.metadata_format(ENUMS::IMAGE_FORMATS::LARGE).first unless images.loaded?
    images.find { |image| image.blob.metadata["format"] == ENUMS::IMAGE_FORMATS::LARGE }
  end

  def assign_large_image(blob_id)
    creative_image = creative_images.large.first_or_initialize
    image = organization.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def wide_image
    return images.metadata_format(ENUMS::IMAGE_FORMATS::WIDE).first unless images.loaded?
    images.find { |image| image.blob.metadata["format"] == ENUMS::IMAGE_FORMATS::WIDE }
  end

  def assign_wide_image(blob_id)
    creative_image = creative_images.wide.first_or_initialize
    image = organization.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def sponsor_image
    return images.metadata_format(ENUMS::IMAGE_FORMATS::SPONSOR).first unless images.loaded?
    images.find { |image| image.blob.metadata["format"] == ENUMS::IMAGE_FORMATS::SPONSOR }
  end

  def assign_sponsor_image(blob_id)
    creative_image = creative_images.sponsor.first_or_initialize
    image = organization.images.where(blob_id: blob_id).first
    creative_image.active_storage_attachment_id = image.id
    creative_image.save!
  end

  def cloned_images
    @cloned_images || {}
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def touch_campaigns
    campaigns.map(&:touch)
  end

  def validate_status_change
    return unless status_changed?
    return unless campaigns.exists?

    if !active? && campaigns.where(status: ENUMS::CAMPAIGN_STATUSES::ACTIVE).exists?
      errors.add :base, "cannot deactivate creative because it is used by an active campaign"
    end
  end

  def validate_ad_copy_length
    return unless body.length + headline.length + 1 > MAX_AD_COPY_LENGTH
    errors.add :base, "ad headline, and body cannot exceed a combined #{MAX_AD_COPY_LENGTH} characters."
  end

  def validate_destroyable
    return unless DailySummary.find_by(scoped_by_type: "Creative", scoped_by_id: id)
    errors.add :base, "Record has associated daily summaries, try archiving it instead."
    throw :abort
  end
end
