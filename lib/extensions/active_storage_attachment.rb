# frozen_string_literal: true

module CodeFundAds::Extensions
  module ActiveStorageAttachment
    extend ActiveSupport::Concern

    included do
      scope :metadata_name, -> (value) do
        subquery = ActiveStorage::Blob.arel_table[:id].eq(arel_table[:blob_id])
        where blob_id: ActiveStorage::Blob.where(subquery).metadata_name(value)
      end

      scope :metadata_format, -> (value) do
        subquery = ActiveStorage::Blob.arel_table[:id].eq(arel_table[:blob_id])
        where blob_id: ActiveStorage::Blob.where(subquery).metadata_format(value)
      end
    end
  end
end
