namespace :properties do
  desc "Backfill prohibited organization ids"
  task backfill_prohibited_org_ids: :environment do
    properties = Property.with_prohibited_advertiser_ids
  end
end
