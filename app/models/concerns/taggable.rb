module Taggable
  extend ActiveSupport::Concern

  included do
    include TagColumns
  end
end
