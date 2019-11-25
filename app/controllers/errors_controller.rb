class ErrorsController < ApplicationController
  def error
    status = (params[:code] || 500)
    render status.to_s
  end
end
