# frozen_string_literal: true

json.array! @users, partial: "users/zinggrid/user", as: :user
