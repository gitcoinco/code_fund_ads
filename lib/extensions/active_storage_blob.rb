# frozen_string_literal: true

module CodeFundAds::Extensions
  module ActiveStorageBlob
    extend ActiveSupport::Concern

    module ClassMethods
      def quote_column(name)
        [
          quoted_table_name,
          connection.quote_column_name(name)
        ].join(".")
      end
    end

    included do
      before_save -> do
        self.indexed_metadata = metadata || {}
      end

      scope :search_metadata, -> (key, *values) do
        values = values.reject(&:blank?)
        case
        when values.blank? then all
        when values.one? then where("#{quote_column :indexed_metadata} ->> ? ILIKE ?", key, "%#{values.first}%")
        else where("#{quote_column :indexed_metadata} ->> ? in (?)", key, values)
        end
      end

      scope :search_metadata_format, -> (*values) { search_metadata :format, *values }
      scope :search_metadata_name, -> (value) { search_metadata_name :name, value }
      scope :search_metadata_description, -> (value) { search_metadata :description, value }
    end
  end
end
