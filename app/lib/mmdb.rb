module MMDB
  class << self
    def lookup(ip_address)
      return MaxMindDB::Result.new({}) unless mmdb
      mmdb.lookup ip_address
    end

    private

    def mmdb_path
      Dir.glob(Rails.root.join("db/maxmind/**/GeoLite2-City.mmdb")).first
    end

    def mmdb
      @mmdb ||= create_mmdb(mmdb_path)
      @mmdb = create_mmdb(mmdb_path) if refresh?
      @mmdb
    end

    def create_mmdb(path)
      DownloadMaxmindFilesJob.perform_later
      return nil unless path
      Rails.cache.write :mmdb, true, expires_in: 1.day
      MaxMindDB.new path
    end

    def refresh?
      !Rails.cache.read(:mmdb)
    end
  end
end
