class PagesController < ApplicationController
  def index
    redirect_to current_user ? helpers.default_dashboard_path(current_user) : new_user_session_path
  end
end
