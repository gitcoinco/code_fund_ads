class ApplicationJob < ActiveJob::Base
  include Rollbar::ActiveJob
  delegate :instrument, to: ActiveSupport::Notifications
  retry_on ActiveJob::DeserializationError, wait: 15.seconds, attempts: 2
end
