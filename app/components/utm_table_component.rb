class UtmTableComponent < ApplicationComponent
  def initialize(campaign: nil)
    @campaign = campaign
  end

  private

  attr_reader :campaign
end
