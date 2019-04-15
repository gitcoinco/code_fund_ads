class RecalculateOrganizataionBalancesJob < ApplicationJob
  queue_as :default

  def perform
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    Organization.all.each(&:recalculate_balance!)
  end
end
