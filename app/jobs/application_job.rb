class ApplicationJob < ActiveJob::Base
  include ::NSA::Statsd::Publisher
end
