# frozen_string_literal: true

json.extract! user, :id, :created_at, :updated_at, :email, :last_sign_in_at
json.full_name user.full_name
json.avatar user.avatar
json.accepted_or_not_invited user.accepted_or_not_invited?
json.organization user.organization
json.roles user.roles
