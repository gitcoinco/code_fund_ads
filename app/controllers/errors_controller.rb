class ErrorsController < ApplicationController
  layout "authentication"
  def error
    status = (params[:code] || 500)
    respond_to do |format|
      format.html { render status.to_s }
      format.json { render status: status }
      format.js { render status: status }
    end
  end
end
