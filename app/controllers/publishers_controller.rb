class PublishersController < ApplicationController
  def index
    @applicant = Applicant.new(role: "publisher")
  end

  def create
    @applicant = Applicant.new(applicant_params)

    if session[:ref].present?
      impression = Impression.where(id: session[:ref]).first
      @applicant.referring_campaign_id = impression&.campaign_id
      @applicant.referring_property_id = impression&.property_id
      @applicant.referring_impression_id = impression&.id
    end

    if @applicant.save
      redirect_to publishers_path, notice: "Your request was sent successfully. We will be in touch."
    else
      flash.now[:error] = "Your application is not valid. Please correct the errors and try again"
      render :index
    end
  end

  private

  def applicant_params
    params.require(:applicant).permit(
      :role,
      :status,
      :first_name,
      :last_name,
      :email,
      :url,
      :monthly_visitors,
    )
  end
end
