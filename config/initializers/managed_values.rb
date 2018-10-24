# frozen_string_literal: true

path = Rails.root.join("config/managed_values.yml")
raw = File.read(path)
hash = YAML.safe_load(raw)

MANAGED_VALUES = HashWithIndifferentAccess.new(hash)
MANAGED_VALUES.each { |_, value| value.freeze }
MANAGED_VALUES.freeze
