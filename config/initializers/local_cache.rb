def Rails.local_ephemeral_cache
  @local_ephemeral_cache ||= ActiveSupport::Cache::MemoryStore.new(expires_in: 1.hour)
end
