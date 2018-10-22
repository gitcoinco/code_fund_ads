# frozen_string_literal: true

json.array! @invitations, partial: 'invitations/invitation', as: :invitation
