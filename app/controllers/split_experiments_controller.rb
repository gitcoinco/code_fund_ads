class SplitExperimentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_campaign

  def update
    return head(:unauthorized) unless authorized_user.can_update_split_experiment?(@campaign)
    @campaign&.split_experiment&.winner = params[:winner_name]
    head :ok
  end

  def destroy
    return head(:unauthorized) unless authorized_user.can_destroy_split_experiment?(@campaign)
    @campaign&.split_experiment&.delete
    head :ok
  end

  private

  def set_campaign
    @campaign ||= Campaign.find_by(id: params[:id])
  end
end
