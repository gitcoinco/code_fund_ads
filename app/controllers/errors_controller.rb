class ErrorsController < ApplicationController
  layout "authentication"
  def error
    status = (params[:code] || 500)
    render status.to_s
  end
end
