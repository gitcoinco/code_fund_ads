class API::Base < Grape::API
  helpers API::Auth
  
  mount API::Emails
  mount API::Users

  # :nocov:
  if Rails.env.development? 
    add_swagger_documentation add_version: true
  end
  # :nocov:
end