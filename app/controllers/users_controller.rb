# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user_search, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    users = User.include_image_count.order(:company_name, :first_name, :last_name)
    users = @user_search.apply(users)
    @pagy, @users = pagy(users)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_user_search
      @user_search = GlobalID.parse(session[:user_search]).find if session[:user_search].present?
      @user_search ||= UserSearch.new
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:id] == "me"
        @user = current_user
      else
        @user = User.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :avatar, :first_name, :last_name, :email, :company_name, :paypal_email, :address_1,
        :address_2, :city, :region, :postal_code, :country, :api_access, :us_resident, :bio,
        :website_url, :github_username, :twitter_username, :linkedin_username, skills: [], roles: []
      )
    end
end
