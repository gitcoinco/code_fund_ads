class MasterAnalyzer < ActiveStorage::Analyzer
  def self.accept?(_blob)
    true
  end

  # Collect metadata from all of the other analyzers to add to the blob
  def metadata
    analyzers.collect(&:metadata).compact.reduce(:merge) || HashWithIndifferentAccess.new
  rescue => e
    Rollbar.error e
    HashWithIndifferentAccess.new
  end

  private

  def analyzers
    Rails.application.config.document_analyzers
      .select { |analyzer_class| analyzer_class.accept? @blob }
      .collect { |analyzer_class| analyzer_class.new(@blob) }
  end
end
