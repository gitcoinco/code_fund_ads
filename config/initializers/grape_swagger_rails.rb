unless Rails.env.production?
  GrapeSwaggerRails.options.app_name = 'CodeFund API'
  GrapeSwaggerRails.options.app_url  = '/'
  GrapeSwaggerRails.options.url = 'api/v1/swagger_doc.json'
  GrapeSwaggerRails.options.api_key_name = 'api_key'
  GrapeSwaggerRails.options.api_key_type = 'query'
  
end