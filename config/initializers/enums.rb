# frozen_string_literal: true

path = Rails.root.join("config/enums.yml")
raw = File.read(path)
hash = YAML.safe_load(raw)

ENUMS = HashWithIndifferentAccess.new(hash)
ENUMS.each { |_, value| value.freeze }
ENUMS.freeze
