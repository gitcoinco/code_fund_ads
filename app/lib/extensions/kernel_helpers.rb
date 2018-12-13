module Extensions
  module KernelHelpers
    extend ActiveSupport::Concern

    included do
      alias_method :then, :yield_self
    end
  end
end
