# frozen_string_literal: true

json.extract! property, :id, :created_at, :updated_at
json.url property_url(property, format: :json)
