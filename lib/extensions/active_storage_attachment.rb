# frozen_string_literal: true

module CodeFundAds::Extensions
  module ActiveStorageAttachment
    extend ActiveSupport::Concern

    module ClassMethods
      def blob_relation
        ActiveStorage::Blob.where ActiveStorage::Blob.arel_table[:id].eq(arel_table[:blob_id])
      end
    end

    included do
      scope :search_filename, -> (value) { where blob_id: blob_relation.search_filename(value) }
      scope :search_metadata_format, -> (*values) { where blob_id: blob_relation.search_metadata_format(*values) }
      scope :search_metadata_name, -> (value) { where blob_id: blob_relation.search_metadata_name(value) }
      scope :search_metadata_description, -> (value) { where blob_id: blob_relation.search_metadata_description(value) }
    end

    def my_record?(record)
      record_type = record.class.name && record_id == record.id
    end
  end
end
