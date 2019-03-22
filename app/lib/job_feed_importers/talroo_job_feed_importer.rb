require 'aws-sdk-s3'

class TalrooJobFeedImporter
  URL = 'http://www2.jobs2careers.com/feed.php?id=3693-5858&pass=dMoFet54eZlJBbhu'.freeze

  def self.start
    new.download
  end

  def self.import(s3_path)
    new.import_file_from(s3_path)
  end

  def import_file(s3_path)
    req = Typhoeus::Request.new(s3_path)
    req.on_body do |chunk|
    end
    request.run
  end

  def download
    feed_file = download_feed_file
    feed_file_path = send_to_s3(feed_file)
    enqueue_import(feed_file_path)
  end

  private

  def download_feed_file
    feed_file = nil
    req = Typhoeus.get(URL)
    req.on_complete do |res|
      feed_file = res.body
    end
    feed_file
  end

  def send_to_s3(feed_file)
  end

end
