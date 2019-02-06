class PropertiesController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :set_property_search, only: [:index]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }

  def index
    properties = Property.order(order_by).includes(:user)
    if authorized_user.can_admin_system?
      properties = properties.where(user: @user) if @user
    else
      properties = properties.where(user: current_user)
    end
    properties = @property_search.apply(properties)
    @pagy, @properties = pagy(properties)

    render "/properties/for_user/index" if @user
  end

  def show
  end

  def new
    @property = current_user.properties.build(status: "pending", ad_template: "default", ad_theme: "light")
  end

  def edit
  end

  def create
    @property = current_user.properties.build(property_params)
    @property.status = "pending"

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_property_search
    @property_search = GlobalID.parse(session[:property_search]).find if session[:property_search].present?
    @property_search ||= PropertySearch.new
  end

  def set_property
    @property = if authorized_user.can_admin_system?
      Property.find(params[:id])
    else
      current_user.properties.find(params[:id])
    end
  end

  def set_user
    @user = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end

  def property_params
    params.require(:property).permit(
      :ad_template,
      :ad_theme,
      :description,
      :language,
      :name,
      :prohibit_fallback_campaigns,
      :property_type,
      :screenshot,
      :url,
      keywords: [],
    ).tap do |whitelisted|
      if authorized_user.can_admin_system?
        whitelisted[:status] = params[:property][:status]
        whitelisted[:prohibited_advertiser_ids] = params[:property][:prohibited_advertiser_ids]
        whitelisted[:revenue_percentage] = params[:property][:revenue_percentage]
      end
    end
  end

  def sortable_columns
    %w[
      created_at
      name
      status
    ]
  end
end
