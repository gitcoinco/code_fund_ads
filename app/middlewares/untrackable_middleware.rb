# frozen_string_literal: true

require "active_support/all"

class UntrackableMiddleware
  PROTECTED = [
    %r{/scripts/.+/embed\.js},
    %r{/api/v1/impression/},
    %r{/t/s/.+/details},
    %r{/properties/.+/funder\..+},
    %r{/display/.+\.gif},
    %r{/impressions/.+/uplift},
    %r{/impressions/.+/click},
    %r{/properties/.+/sponsor},
    %r{/properties/.+/visit-sponsor},
  ].freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    protect = false
    PROTECTED.each { |pattern| protect ||= pattern.match(request.path) }
    env.delete("HTTP_COOKIE") if protect
    status, headers, body = @app.call(env)
    if protect
      headers.delete "Set-Cookie"
      headers = headers.merge("Cookies-Stripped" => "true")
    end
    [status, headers, body]
  end
end
