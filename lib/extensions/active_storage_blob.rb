# frozen_string_literal: true

module CodeFundAds::Extensions
  module ActiveStorageBlob
    extend ActiveSupport::Concern

    module ClassMethods
      def quoted_column(name)
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

      scope :metadata_name, -> (value) { where "#{quoted_column :indexed_metadata} ->> 'name' = ?", value }
      scope :metadata_format, -> (value) { where "#{quoted_column :indexed_metadata} ->> 'format' = ?", value }
    end
  end
end
