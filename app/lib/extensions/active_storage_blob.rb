module Extensions
  module ActiveStorageBlob
    extend ActiveSupport::Concern

    module ClassMethods
      def quote_column(name)
        [
          quoted_table_name,
          connection.quote_column_name(name),
        ].join(".")
      end
    end

    included do
      before_save :set_indexed_metadata

      scope :search_column, ->(column_name, value) do
        where arel_table[column_name].lower.matches("%#{model.send :sanitize_sql_like, value.downcase}%")
      end

      scope :search_metadata, ->(key, *values) do
        values = values.reject(&:blank?)
        if values.blank? then all
        elsif values.one? then where("#{quote_column :indexed_metadata} ->> ? ILIKE ?", key, "%#{values.first}%")
        else where("#{quote_column :indexed_metadata} ->> ? in (?)", key, values)
        end
      end

      scope :search_metadata_format, ->(*values) { search_metadata :format, *values }
      scope :search_metadata_name, ->(value) { search_metadata :name, value }
      scope :search_metadata_description, ->(value) { search_metadata :description, value }
      scope :search_filename, ->(value) { value.blank? ? all : search_column(:filename, value) }
    end

    def set_indexed_metadata
      self.indexed_metadata = metadata
    end
  end
end
