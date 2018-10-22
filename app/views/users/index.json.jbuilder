# frozen_string_literal: true

json.array! @users, partial: 'users/user', as: :user
