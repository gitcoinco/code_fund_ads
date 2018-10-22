# frozen_string_literal: true

json.array! @creatives, partial: 'creatives/creative', as: :creative
