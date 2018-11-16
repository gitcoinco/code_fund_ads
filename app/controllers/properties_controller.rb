# frozen_string_literal: true

class PropertiesController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :set_property_search, only: [:index]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }

  # GET /properties
  # GET /properties.json
  def index
    properties = Property.order(order_by).includes(:user)
    properties = properties.where(user: @user) if @user
    properties = @property_search.apply(properties)
    @pagy, @properties = pagy(properties)

    puts "ORDER BY: #{order_by}"

    render "/properties/for_user/index" if @user
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new(status: "pending")
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = current_user.properties.build(property_params)

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

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
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

  # DELETE /properties/1
  # DELETE /properties/1.json
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

    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    def set_user
      if params[:user_id] == "me"
        @user = current_user
      else
        @user = User.find(params[:user_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :url, :status, :language, :description, :property_type, keywords: [])
    end

    def sortable_columns
      %w( name status created_at )
    end
end
