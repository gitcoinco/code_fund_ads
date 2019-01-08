class EmailTemplatesController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_email_template, only: [:show, :edit, :update, :destroy]

  def index
    email_templates = EmailTemplate.order(:title)
    @pagy, @email_templates = pagy(email_templates)
  end

  def show
    @applicant = Applicant.new(
      role: "publisher",
      first_name: "Kevin",
      last_name: "Owocki",
      email: "kevin@gitcoin.co",
      company_name: "Gitcoin",
      url: "https://gitcoin.co",
      monthly_visitors: "50,000 - 250,000",
      monthly_budget: "$1,000 - $2,499"
    )
    subject_template = Liquid::Template.parse(@email_template.subject)
    body_template = Liquid::Template.parse(@email_template.body)
    @subject = subject_template.render(@applicant.liquid_attributes)
    @body = body_template.render(@applicant.liquid_attributes)
  end

  def new
    @email_template = EmailTemplate.new
  end

  def create
    @email_template = EmailTemplate.new(email_template_params)

    respond_to do |format|
      if @email_template.save
        format.html { redirect_to @email_template, notice: "Email template was successfully created." }
        format.json { render :show, status: :created, location: @email_template }
      else
        format.html { render :new }
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @email_template.update(email_template_params)
        format.html { redirect_to @email_template, notice: "Email template was successfully updated." }
        format.json { render :show, status: :ok, location: @email_template }
      else
        format.html { render :edit }
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email_template.destroy
    respond_to do |format|
      format.html { redirect_to email_templates_url, notice: "Email template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_email_template
    @email_template = EmailTemplate.find(params[:id])
  end

  def email_template_params
    params.require(:email_template).permit(
      :title,
      :subject,
      :body
    )
  end
end
