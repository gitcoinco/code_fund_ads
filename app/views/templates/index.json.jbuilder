# frozen_string_literal: true

json.array! @templates, partial: 'templates/template', as: :template
