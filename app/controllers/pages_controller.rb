class PagesController < ApplicationController
  before_action :redirect_to_wordpress
  before_action :verify_page, only: [:show]

  def index
    # To be a showcase publisher, an image must exist at app/assets/images/home/browser-#{short_name}.png
    @showcase_publishers = [
      {short_name: "jsbin", url: "https://jsbin.com"},
      {short_name: "material-ui", url: "https://material-ui.com"},
      {short_name: "codesandbox", url: "https://codesandbox.io"},
      {short_name: "codier", url: "https://codier.io"},
      {short_name: "daily", url: "https://www.dailynow.co"},
      {short_name: "vuetify", url: "https://vuetifyjs.com"},
      {short_name: "redux-form", url: "https://redux-form.com"},
    ]
  end

  private

  def redirect_to_wordpress
    redirect_to "https://codefund.io"
  end

  def verify_page
    render_not_found unless ENUMS::PAGES.values.any?(params[:id])
  end
end
