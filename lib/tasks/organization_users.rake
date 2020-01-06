namespace :organization_users do
  desc "Migrate all owner role names to administrator"
  task update_roles: :environment do
    OrganizationUser.where(role: "owner").update_all(role: ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR)
  end
end
