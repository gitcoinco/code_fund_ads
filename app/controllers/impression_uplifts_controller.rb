class ImpressionUpliftsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cors_headers

  def create
    Impression
      .partitioned(params[:advertiser_id], Date.current)
      .where(id: params[:impression_id])
      .update_all(uplift: true)
    head :ok
  end
end
