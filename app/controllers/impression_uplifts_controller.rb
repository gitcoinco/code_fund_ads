class ImpressionUpliftsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cors_headers

  def create
    RecordUpliftJob.perform_later params[:advertiser_id], params[:impression_id]
    head :ok
  end
end
