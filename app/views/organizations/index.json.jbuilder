# frozen_string_literal: true

json.array! @organizations, partial: "organizations/organization", as: :organization
