require "net/http"
require "fileutils"
require "zlib"
require "rubygems/package"

class DownloadMaxmindFilesJob < ApplicationJob
  queue_as :low

  def perform
    download(geoip2_city_uri, geoip2_city_path).
      then { |path| unzip path }.
      then { |path| untar path }
  end

  private

  def maxmind_path
    Rails.root.join("db/maxmind").tap do |path|
      FileUtils.mkdir_p path
    end
  end

  def geoip2_city_uri
    URI "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz"
  end

  def geoip2_city_path
    maxmind_path.join "GeoLite2-City.tar.gz"
  end

  def download(uri, local_path)
    FileUtils.rm_f local_path
    File.open local_path, "wb" do |file|
      Net::HTTP.start(uri.host) do |http|
        http.open_timeout = 1
        http.read_timeout = 1
        http.request_get("#{uri.path}?#{uri.query}") do |response|
          response.read_body { |segment| file.write segment }
        end
      end
    end
    local_path
  end

  def unzip(zipped_path)
    unzipped_path = zipped_path.sub(/\.gz\z/, "")
    File.open unzipped_path, "wb" do |unzipped_file|
      Zlib::GzipReader.open zipped_path do |zipped_file|
        zipped_file.each_line { |line| unzipped_file.write line }
      end
    end
    FileUtils.rm zipped_path
    unzipped_path
  end

  def untar(tarred_path)
    Gem::Package::TarReader.new File.open(tarred_path) do |tar|
      tar.each do |tarfile|
        destination = maxmind_path.join(tarfile.full_name)

        if tarfile.directory?
          FileUtils.mkdir_p destination
        else
          FileUtils.mkdir_p File.dirname(destination)
          File.open destination, "wb" do |f|
            f.print tarfile.read
          end
        end
      end
    end
  end
end
