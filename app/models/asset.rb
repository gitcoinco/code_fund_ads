# frozen_string_literal: true

# == Schema Information
#
# Table name: assets
#
#  user_id      :uuid
#  id           :uuid             not null, primary key
#  name         :string(255)      not null
#  image_object :string(255)      not null
#  image_bucket :string(255)      not null
#  inserted_at  :datetime         not null
#  updated_at   :datetime         not null
#  height       :integer
#  width        :integer
#

class Asset < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :user
  has_many :creatives_as_large_asset, class_name: "Creative", foreign_key: "large_image_asset_id"
  has_many :creatives_as_small_asset, class_name: "Creative", foreign_key: "small_image_asset_id"
  has_many :creatives_as_wide_asset, class_name: "Creative", foreign_key: "wide_image_asset_id"

  # validations ...............................................................
  validates :image_bucket, length: {maximum: 255, allow_blank: false}
  validates :image_object, length: {maximum: 255, allow_blank: false}
  validates :name, length: {maximum: 255, allow_blank: false}

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
