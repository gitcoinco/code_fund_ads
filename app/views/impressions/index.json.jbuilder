# frozen_string_literal: true

json.array! @impressions, partial: 'impressions/impression', as: :impression
