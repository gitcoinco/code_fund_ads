# frozen_string_literal: true

module Properties
  module Presentable
    extend ActiveSupport::Concern

    def display_url
      url.gsub(/https?:\/\//, "")
    end
  end
end
