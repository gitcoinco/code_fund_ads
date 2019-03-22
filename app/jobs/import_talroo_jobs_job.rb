class ImportTalrooJobsJob < ApplicationJob
  queue_as :default

  def perfrom(s3_file_path)
    TalrooJobFeedImport.import(s3_file_path)
  end
end
