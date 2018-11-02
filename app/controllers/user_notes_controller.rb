# frozen_string_literal: true

class UserNotesController < ApplicationController
  before_action :set_user

  def index
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end
end
