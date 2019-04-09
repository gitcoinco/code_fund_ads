namespace :debits do
  desc "Rebuild debits"
  task rebuild: :environment do
    start_date = Date.parse("2019-01-01")
    end_date = Date.current.advance(days: 1)
    Organization.all.each do |organization|
      puts "organization:#{organization.id} debits:#{organization.organization_transactions.debits.count}"
      organization.organization_transactions.debits.where("description ~ '^Daily Spend on'").posted_between(start_date, end_date).each do |debit|
        new_balance = organization.balance + debit.amount
        puts "destroying debit:#{debit.id} #{debit.reference}"
        puts "updating organization:#{organization.id} old_balance:#{organization.balance.format} new_balance:#{new_balance.format}"
        debit.destroy!
        organization.update! balance: new_balance
      end

      (start_date..end_date).each do |date|
        organization.campaigns.pluck(:id).each do |campaign_id|
          puts "creating debit: #{campaign_id}:#{date.iso8601}"
          CreateDebitForCampaignAndDateJob.perform_now(campaign_id, date.iso8601)
        end
      end

      puts
    end
  end
end
