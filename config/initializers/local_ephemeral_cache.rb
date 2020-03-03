def Rails.local_ephemeral_cache
  @local_ephemeral_cache ||= ActiveSupport::Cache::MemoryStore.new(
    expires_in: 2.hours,
    size: ENV.fetch("LOCAL_EPHEMERAL_CACHE_MEGABYTES", 64).to_i.megabytes
  )
end
