module Extensions
  module KernelThen
    extend ActiveSupport::Concern

    included do
      alias_method :then, :yield_self
    end
  end
end
