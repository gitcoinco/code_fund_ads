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
      scope :search_user_id, ->(value) { value.blank? ? all : search_column(:record_id, value) }
      scope :metadata_format, ->(*values) { where "#{quote_column :indexed_metadata} ->> 'format' = any(?)", "{#{values.join ","}}" }
    end

    def set_indexed_metadata
      self.indexed_metadata = metadata
    end

    def cloudfront_host
      ENV["CLOUDFRONT_HOST"]
    end

    def cloudfront_url
      return service_url unless cloudfront_host
      return service_url unless defined?(ActiveStorage::Service::S3Service)
      return service_url unless service.is_a?(ActiveStorage::Service::S3Service)
      uri = URI(service_url)
      path = uri.path.gsub("/#{service.bucket.name}", "")
      "https://#{cloudfront_host}#{path}"
    rescue => e1
      Rollbar.error e1
      begin
        service_url
      rescue => e2
        Rollbar.error e2
        ""
      end
    end
  end
end
