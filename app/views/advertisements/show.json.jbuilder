json.cache! [@property, @campaign], expires_in: 6.hours do
  json.template @payload[:template]
  json.theme @payload[:theme]
end
