# frozen_string_literal: true

json.extract! distribution, :id, :created_at, :updated_at
json.url distribution_url(distribution, format: :json)
