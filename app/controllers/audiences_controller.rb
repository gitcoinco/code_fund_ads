class AudiencesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :authenticate_administrator!, only: :index

  def index
    audiences = Audience.all
    @pagy, @audiences = pagy(audiences)
  end
end
