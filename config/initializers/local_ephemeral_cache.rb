if Rails.env.test?
  def Rails.local_ephemeral_cache
    @local_ephemeral_cache ||= ActiveSupport::Cache::NullStore.new
  end
else
  def Rails.local_ephemeral_cache
    @local_ephemeral_cache ||= ActiveSupport::Cache::MemoryStore.new(
      size: ENV.fetch("LOCAL_EPHEMERAL_CACHE_MEGABYTES", 64).to_i.megabytes,
      expires_in: 1.hour
    )
  end
end
