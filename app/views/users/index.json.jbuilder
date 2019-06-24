# frozen_string_literal: true

json.pagination @pagy
json.results @users do |user|
  json.extract! user, :id, :created_at, :updated_at, :last_sign_in_at, :first_name, :email
  json.full_name user.full_name
  json.avatar_image_url user.avatar_image_url
  json.is_advertiser user.advertiser?
  json.organization user.organization
  json.accepted_or_not_invited user.accepted_or_not_invited?
  json.blacklisted user.blacklisted?
  json.roles user.roles
  json.gid_param user.to_gid_param
end
