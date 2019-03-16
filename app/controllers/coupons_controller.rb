class CouponsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_coupon, only: [:edit, :update, :destroy]

  def index
    coupons = Coupon.order(created_at: :desc)
    @pagy, @coupons = pagy(coupons)
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params.merge(coupon_type: ENUMS::COUPON_TYPES::PERCENTAGE))

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to coupons_path, notice: "Coupon was successfully created." }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: "Coupon was successfully updated." }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_path, notice: "Coupon was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(
      :code,
      :description,
      :discount_percent,
      :quantity,
      :claimed
    ).tap do |whitelisted|
      whitelisted[:expires_at] = Chronic.parse(params[:coupon][:expires_at])
    end
  end
end
