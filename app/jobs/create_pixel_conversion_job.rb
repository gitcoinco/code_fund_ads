class CreatePixelConversionJob < ApplicationJob
  queue_as :default

  def perform(params = {})
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f

    Pixel.find_by(id: params[:pixel_id])&.record_conversion(
      params[:impression_id],
      conversion_referrer: params[:conversion_referrer],
      test: params[:test],
      metadata: params[:metadata] || {}
    )
  end
end
