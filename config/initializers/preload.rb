begin
  Mmdb.mmdb
rescue => e
  Rails.logger.error "Failed to preload MaxMindDB data! #{e}"
end
begin
  Country.all
rescue
  Rails.logger.error "Failed to preload Countries GEM data! #{e}"
end
