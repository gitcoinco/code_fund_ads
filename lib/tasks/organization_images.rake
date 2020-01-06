namespace :organization_images do
  desc "Backfill organization images"
  task backfill: :environment do
    ActiveStorage::Attachment.where(record_type: "User", name: "images").each do |asa|
      asa.update(record_type: "Organization", record_id: asa.record.organizations.first.id)
    end
  end
end
