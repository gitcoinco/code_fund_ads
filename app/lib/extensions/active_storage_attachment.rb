module Extensions
  module ActiveStorageAttachment
    extend ActiveSupport::Concern

    module ClassMethods
      def blob_relation
        ActiveStorage::Blob.where ActiveStorage::Blob.arel_table[:id].eq(arel_table[:blob_id])
      end
    end

    included do
      scope :search_filename, ->(value) { value.blank? ? all : where(blob_id: blob_relation.search_filename(value)) }
      scope :search_metadata_format, ->(*values) { values.blank? ? all : where(blob_id: blob_relation.search_metadata_format(*values)) }
      scope :search_metadata_name, ->(value) { value.blank? ? all : where(blob_id: blob_relation.search_metadata_name(value)) }
      scope :search_metadata_description, ->(value) { value.blank? ? all : where(blob_id: blob_relation.search_metadata_description(value)) }
      scope :search_user_id, ->(value) { value.blank? ? all : where(blob_id: blob_relation.search_user_id(value)) }
      scope :metadata_format, ->(*values) { values.blank? ? all : where(blob_id: blob_relation.metadata_format(*values)) }
    end

    def my_record?(record)
      record_type == record.class.name && record_id == record.id
    end
  end
end
