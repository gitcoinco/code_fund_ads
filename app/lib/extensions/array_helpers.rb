module Extensions
  module ArrayHelpers
    extend ActiveSupport::Concern

    def avg
      map(&:to_f).sum / size.to_f
    end
  end
end
