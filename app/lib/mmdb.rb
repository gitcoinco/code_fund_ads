module MMDB
  class << self
    def lookup(ip_address)
      return MaxMindDB::Result.new({}) unless mmdb

      begin
        result = mmdb.lookup(ip_address)
      rescue StandardError => e
        Rails.logger.error "Error performing lookup on ip address! #{ip_address} #{e}"
        result = MaxMindDB::Result.new({})
      end

      result
    end

    private

    def mmdb_path
      Dir.glob("/tmp/**/GeoLite2-City.mmdb").first
    end

    def mmdb
      @mmdb ||= begin
        DownloadMaxmindFilesJob.perform_later if refresh?
        Rails.cache.write :mmdb, true, expires_in: 1.day
        create_mmdb
      end
    end

    def create_mmdb
      return nil unless mmdb_path.present?
      MaxMindDB.new mmdb_path
    end

    def refresh?
      return true unless mmdb_path.present?
      !Rails.cache.read(:mmdb)
    end
  end
end
