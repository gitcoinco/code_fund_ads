namespace :data do
  namespace :impressions do
    desc "Imports impressions records from: ~/Downloads/impressions.csv"
    task import: :environment do
      Impression.connection.execute "COPY impressions(id,advertiser_id,publisher_id,campaign_id,creative_id,property_id,ip_address,user_agent,country_code,postal_code,latitude,longitude,displayed_at,displayed_at_date,clicked_at,clicked_at_date,fallback_campaign,estimated_gross_revenue_fractional_cents,estimated_property_revenue_fractional_cents,estimated_house_revenue_fractional_cents,ad_template,ad_theme,organization_id,uplift,province_code) FROM '#{ENV["HOME"]}/Downloads/impressions.csv' DELIMITER ',' CSV HEADER;"
    end
  end

  namespace :publishers do
    task :purge, [:user_id] => [:environment] do |_task, args|
      user = User.publishers.find_by(id: args[:user_id])
      exit_early "User not found" unless user

      puts "Are you sure you want to delete user #{user.id}: #{user.full_name} <#{user.email}>? [y/N]"
      puts "This cannot be undone!"
      exit_early "No action taken" unless yes?

      puts "Do you want to delete all of their properties? [y/N]"
      puts "This cannot be undone!"
      if yes?
        user.properties.each do |property|
          puts "Deleting property #{property.id}: #{property.name} <#{property.url}>"
          property.destroy!
        end
      end

      puts "Deleting user #{user.id}: #{user.full_name} <#{user.email}>"
      user.destroy!
    end
  end

  private

  def yes?
    !!(STDIN.gets.strip =~ /\Ay\z/i)
  end

  def exit_early(message)
    puts message
    exit 0
  end
end
