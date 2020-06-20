class ZapierController < ActionController::Base
  before_action :authenticate_api_user!
  respond_to :json

  def me
    render json: @user.to_builder.target!
  end
  
  def account_managers
    users = User.account_managers.sort_by(&:name).each_with_object({}) do |user, memo|
      memo[user.id] = user.name
    end
    render json: users.to_builder.target!
  end

  def organization
    organization = @user.organizations.find_by(params[:id])
    render json: organization.to_builder.target!
  end

  def create_organization
    organization = @user.organizations.build(organization_params)
    if organization.save
      render json: organization.to_builder.target!, status: :created
    else
      render json: organization.errors, status: :unprocessable_entity
    end
  end

  private

  def authenticate_api_user!
    user = User.find_for_authentication(email: authentication_params[:email])
    @user = user.valid_password?(authentication_params[:password]) ? user : nil
    render json: {
      "success": false,
      "message": "Invalid email and/or password"
    }, status: 403 unless @user
  end

  def authentication_params
    params.permit(:email, :password)
  end

  def organization_params
    params.require(:organization).permit(
      :name,
      :account_manager_user_id,
      :creative_approval_needed,
      :url
    )
  end
end
