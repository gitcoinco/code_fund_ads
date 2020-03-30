namespace :data do
  desc "Archives detached impression tables by dumping the data, uploading to S3, and dropping the table."
  task archive_impressions: :environment do
    credentials = Aws::Credentials.new(ENV["AWS_S3_ACCESS_KEY_ID"], ENV["AWS_S3_SECRET_ACCESS_KEY"])
    s3 = Aws::S3::Resource.new(region: ENV["AWS_S3_REGION"], credentials: credentials)
    bucket = s3.bucket("codefund-backups")

    Impression.detached_table_names.each do |detached_table_name|
      file_name = "#{detached_table_name}.dump"
      file_path = Rails.root.join("tmp", file_name)
      puts "Dumping #{detached_table_name} and uploading to S3: #{bucket.name}/#{Rails.env}/impressions/#{detached_table_name}.dump"

      object = bucket.object("#{Rails.env}/impressions/#{detached_table_name}.dump")
      system "pg_dump --no-acl --no-owner --format=custom --table=#{detached_table_name} #{ENV["DATABASE_URL"]} > #{file_path}"
      object.upload_file file_path

      Impression.connection.exec_query "DROP TABLE #{detached_table_name};" if object.content_length > 0
    end
  end
end
