# frozen_string_literal: true

json.extract! creative, :id, :created_at, :updated_at
json.url creative_url(creative, format: :json)
