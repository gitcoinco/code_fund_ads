module Organizations
  module Developable
    extend ActiveSupport::Concern

    module ClassMethods
      def codefund
        find_by name: "CodeFund"
      end
    end
  end
end
