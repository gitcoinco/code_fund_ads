# frozen_string_literal: true

ApplicationRecord.extend ModelProbe if Rails.env.development?
