module Users
  module Developable
    extend ActiveSupport::Concern

    module ClassMethods
      def eric
        find_by email: "eric@codefund.io"
      end

      def nate
        find_by email: "nate@codefund.io"
      end
    end

    included do
      scope :developers, -> { where email: %w[eric@codefund.io nate@codefund.io] }
    end
  end
end
