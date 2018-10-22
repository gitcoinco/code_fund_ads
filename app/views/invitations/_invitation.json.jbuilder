# frozen_string_literal: true

json.extract! invitation, :id, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
