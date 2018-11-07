# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @showcase_publishers = %w( jsbin material-ui codesandbox codier daily vuetify redux-form )
  end

  def publishers
  end

  def advertisers
  end

  def help
  end
end
