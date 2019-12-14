class FrontController < ActionController::Base
  layout "front"
  before_action :authorize_front
  after_action :allow_iframe

  def show
  end

  private

  def authorize_front
    render "errors/403", status: :forbidden unless ENV["FRONT_SECRETS"].split("|").include? params[:auth_secret]
  end

  def allow_iframe
    response.headers["X-FRAME-OPTIONS"] = "ALLOWALL"
  end
end
