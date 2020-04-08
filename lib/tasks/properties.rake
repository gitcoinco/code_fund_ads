namespace :properties do
  desc "Backfill prohibited organization ids"
  task backfill_prohibited_org_ids: :environment do
    Property.with_prohibited_advertiser_ids.find_each do |property|
      prohibited_organization_ids = property.prohibited_advertiser_ids.map { |id| User.find(id).default_organization.id }
      property.update!(prohibited_organization_ids: prohibited_organization_ids.uniq)
    end
  end
end
