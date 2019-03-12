class UsersController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :authenticate_administrator!, except: [:show, :edit, :update]
  before_action :set_user_search, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, only: [:index], if: -> { params[:organization_id].present? }
  skip_before_action :authenticate_user!, if: -> { params[:redir].present? }
  skip_before_action :authenticate_administrator!, if: -> { params[:redir].present? }

  def index
    users = User.includes(:avatar_attachment, :organization).include_image_count.order(order_by)
    users = @user_search.apply(users)
    users = users.where(organization: @organization) if @organization
    @pagy, @users = pagy(users)

    render "/users/for_organization/index" if @organization
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          return redirect_to(params[:redir]) if params[:redir].present?
          redirect_to success_url, notice: "User was successfully created."
        end
        format.json { render :show, status: :created, location: @user }
      else
        format.html do
          return redirect_to(params[:redir]) if params[:redir].present?
          render :new
        end
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

  def set_user
    @user = if authorized_user.can_admin_system? && params[:id] != "me"
      User.find(params[:id])
    else
      current_user
    end
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def user_params
    params.require(:user).permit(
      :address_1,
      :address_2,
      :avatar,
      :bio,
      :city,
      :company_name,
      :country,
      :email,
      :first_name,
      :github_username,
      :last_name,
      :linkedin_username,
      :paypal_email,
      :postal_code,
      :region,
      :twitter_username,
      :us_resident,
      :website_url,
      skills: [],
    ).tap do |whitelisted|
      if authorized_user.can_admin_system?
        whitelisted[:api_access] = params[:user][:api_access]
        whitelisted[:organization_id] = params[:user][:organization_id]
        whitelisted[:roles] = params[:user][:roles]
      end
    end
  end

  def sortable_columns
    %w[
      company_name
      created_at
      email
      first_name
      last_sign_in_at
    ]
  end
end
