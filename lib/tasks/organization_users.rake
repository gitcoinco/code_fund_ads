namespace :organization_users do
  desc "Backfill organization users"
  task backfill: :environment do
    users = User.where.not(organization_id: nil)

    users.each do |user|
      organization = user.organization
      role = organization.organization_users.present? ? ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR : ENUMS::ORGANIZATION_ROLES::OWNER
      OrganizationUser.create(user: user, organization: organization, role: role)
    end

    puts "Created #{OrganizationUser.all.count} records."
  end
end
