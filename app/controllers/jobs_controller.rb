class JobsController < ApplicationController
  before_action :authenticate_administrator!
end
