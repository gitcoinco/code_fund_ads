module Extensions
  module ModuleHelpers
    # SEE: https://github.com/rails/rails/pull/35035
    def as_json(options = nil) #:nodoc:
      name
    end
  end
end
