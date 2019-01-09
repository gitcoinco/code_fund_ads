class NewsletterSubscriptionsController < ApplicationController
  def create
    AddToMailchimpListJob.perform_later params[:email]
    redirect_back fallback_location: root_path, notice: "You are now subscribed."
  end
end
