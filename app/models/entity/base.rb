# encoding: utf-8
module Entity
  class Base < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.to_i }
    format_with(:to_string) { |dt| dt.to_s }
  end
end