class ApplicationJob < ActiveJob::Base
  include Rollbar::ActiveJob
  delegate :instrument, to: ActiveSupport::Notifications
end
