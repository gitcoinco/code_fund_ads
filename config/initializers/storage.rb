# ActiveStorage does not support multiple analyzers. To get past this, we are setting the analyzers list
# to contain just a MasterAnalyzer. This Analyzer will decide which of the other analyzers to use
# document_analyzers is a list of the analyzers that we will use
Rails.application.config.active_storage.analyzers.delete ActiveStorage::Analyzer::ImageAnalyzer
Rails.application.config.document_analyzers = Rails.application.config.active_storage.analyzers
Rails.application.config.document_analyzers.append CodeFundAdsImageAnalyzer
# MasterAnalyzer is the only one that we pass to active_storage
Rails.application.config.active_storage.analyzers = [MasterAnalyzer]
