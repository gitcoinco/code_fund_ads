# TODO: not being used

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

    if @coupon.save
      redirect_to coupons_path, notice: "Coupon was successfully created."
    else
      render :new, notice: @coupon.errors
    end
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to coupons_path, notice: "Coupon was successfully updated."
    else
      render :edit, notice: @coupon.errors
    end
  end

  def destroy
    if @coupon.destroy
      redirect_to coupons_path, notice: "Coupon was successfully destroyed."
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
      :claimed,
      :expires_at
    ).tap do |whitelisted|
      whitelisted[:expires_at] = Chronic.parse(params[:coupon][:expires_at])
    end
  end
end
