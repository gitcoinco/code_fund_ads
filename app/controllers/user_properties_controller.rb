# frozen_string_literal: true

class UserPropertiesController < ApplicationController
  before_action :set_user
  before_action :set_property_search

  def index
    properties = @user.properties.order(:name).includes(:user, :template)
    properties = @property_search.apply(properties)
    @pagy, @properties = pagy(properties)
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_property_search
      @property_search = PropertySearch.new
    end
end
