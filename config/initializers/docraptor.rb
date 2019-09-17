DocRaptor.configure do |config|
  config.username = ENV.fetch("DOCRAPTOR_API_KEY", "")
  # config.debugging = true
end

$docraptor = DocRaptor::DocApi.new