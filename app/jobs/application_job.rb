class ApplicationJob < ActiveJob::Base
  include Rollbar::ActiveJob
  include ::NSA::Statsd::Publisher
end
