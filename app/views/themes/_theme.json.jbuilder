# frozen_string_literal: true

json.extract! theme, :id, :created_at, :updated_at
json.url theme_url(theme, format: :json)
