class NewsletterSubscriptionsController < ApplicationController
  def create
    CreateNewsletterSubscriptionJob.perform_later params[:email]
    redirect_back fallback_location: root_path, notice: "You are now subscribed."
  end
end
