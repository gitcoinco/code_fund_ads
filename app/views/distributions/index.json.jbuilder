# frozen_string_literal: true

json.array! @distributions, partial: 'distributions/distribution', as: :distribution
