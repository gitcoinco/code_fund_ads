module Extensions
  module LocalCache
    extend ActiveSupport::Concern

    module ClassMethods
      # Returns a cache store instance for the current process.
      def local_cache
        @local_cache ||= if env.production? || (env.development? && root.join("tmp", "caching-dev.txt").exist?)
          ActiveSupport::Cache::MemoryStore.new(max_size: 16.megabytes)
        else
          ActiveSupport::Cache::NullStore.new
        end
      end
    end
  end
end
