json.cache! [@campaign, params[:property_id], @property_updated_at.iso8601], expires_in: 2.hours do
  json.template @template
  json.theme @theme
end
