# frozen_string_literal: true

json.array! @properties, partial: 'properties/property', as: :property
