require "csv"

namespace :legacy do

  desc "Import all"
  task import: :environment do
    Rake::Task["legacy:import_users"].invoke
    Rake::Task["legacy:import_properties"].invoke
    Rake::Task["legacy:import_creatives"].invoke
    Rake::Task["legacy:import_campaigns"].invoke

    u = User.where(email: "eric@codefund.io").first
    u.password = "secret"
    u.password_confirmation = "secret"
    u.roles = ["administrator", "advertiser", "publisher"]
    u.confirmed_at = Time.current
    u.save
  end

  desc "Import legacy user data"
  task import_users: :environment do
    print "Importing Users "
    CSV.foreach(Rails.root.join("legacy/users_20181208.csv"), headers: true, encoding: 'ISO-8859-1:UTF-8') do |row|
      user = User.new
      user.legacy_id             = row["id"]
      user.roles                 = row["roles"][1...-1].
                                      gsub("admin", "administrator").
                                      gsub("sponsor", "advertiser").
                                      gsub("developer", "publisher").
                                      split
      user.first_name            = row["first_name"]&.strip
      user.last_name             = row["last_name"]&.strip
      user.company_name          = row["company"]&.strip
      user.address_1             = row["address_1"]&.strip
      user.address_2             = row["address_2"]&.strip
      user.city                  = row["city"]&.strip
      user.region                = row["region"]&.strip
      user.postal_code           = row["postal_code"]&.strip
      user.country               = row["country"]&.strip
      user.us_resident           = row["us_resident"]
      user.api_access            = row["api_access"]
      user.api_key               = row["api_key"]
      user.paypal_email          = row["paypal_email"]&.strip&.downcase
      user.email                 = row["email"]&.strip&.downcase
      user.password              = SecureRandom.uuid
      user.password_confirmation = user.password
      user.created_at            = row["inserted_at"]
      user.save!
      print "."
    end

    puts " Done!"
  end

  desc "Import legacy property data"
  task import_properties: :environment do
    print "Importing Properties "
    user_ids = User.all.pluck(:legacy_id, :id).to_h
    CSV.foreach(Rails.root.join("legacy/properties_20181208.csv"), headers: true, encoding: 'ISO-8859-1:UTF-8') do |row|
      property               = Property.new
      property.legacy_id     = row["id"]
      property.user_id       = user_ids[row["user_id"]]
      property.property_type = 
        case row["property_type"]
          when "1" then "website"
          when "2" then "repository"
          when "3" then "newsletter"
        end
      property.status = 
        case row["property_type"]
          when "0" then "pending"
          when "1" then "active"
          when "2" then "rejected"
          when "3" then "archived"
          when "4" then "blacklisted"
        end

      property.name          = row["name"]
      property.description   = row["description"]
      property.url           = row["url"]
      property.language      = row["language"].present? ? row["language"] : "English"

      programming_languages = row["programming_languages"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      topic_categories      = row["topic_categories"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      property.keywords     = (programming_languages + topic_categories).uniq.compact.sort

      excluded_advertisers               = row["excluded_advertisers"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      property.prohibited_advertiser_ids = User.where(company_name: excluded_advertisers).pluck(:id)

      property.prohibit_fallback_campaigns = row["no_api_house_ads"]
      property.created_at                  = row["inserted_at"]

      property.save!
      print "."
    end

    puts " Done!"
  end

  desc "Import legacy creative data"
  task import_creatives: :environment do
    print "Importing Creatives "
    user_ids = User.all.pluck(:legacy_id, :id).to_h
    CSV.foreach(Rails.root.join("legacy/creatives_20181208.csv"), headers: true, encoding: 'ISO-8859-1:UTF-8') do |row|
      creative            = Creative.new
      creative.legacy_id  = row["id"]
      creative.user_id    = user_ids[row["user_id"]]
      creative.name       = row["name"]&.strip
      creative.headline   = row["headline"]&.strip
      creative.body       = row["body"]&.strip
      creative.created_at = row["inserted_at"]

      creative.save!
      print "."
    end

    puts " Done!"
  end

  desc "Import legacy campaign data"
  task import_campaigns: :environment do
    print "Importing Campaigns "
    user_ids = User.all.pluck(:legacy_id, :id).to_h
    creative_ids = Creative.all.pluck(:legacy_id, :id).to_h
    CSV.foreach(Rails.root.join("legacy/campaigns_20181208.csv"), headers: true, encoding: 'ISO-8859-1:UTF-8') do |row|
      campaign             = Campaign.new
      campaign.legacy_id   = row["id"]
      campaign.user_id     = user_ids[row["user_id"]]
      campaign.creative_id = creative_ids[row["creative_id"]]
      campaign.status      = 
        case row["status"]
          when "1" then "pending"
          when "2" then "active"
          when "3" then "archived"
        end
      campaign.name                  = row["name"]&.strip
      campaign.url                   = row["redirect_url"]&.strip
      campaign.start_date            = row["start_date"]
      campaign.end_date              = row["end_date"]
      campaign.start_date            ||= 1.year.from_now
      campaign.end_date              ||= campaign.start_date + 3.months
      campaign.us_hours_only         = row["us_hours_only"]
      campaign.weekdays_only         = row["weekdays_only"]
      campaign.total_budget_cents    = row["total_spend"].to_f * 100
      campaign.total_budget_currency = "USD"
      campaign.daily_budget_cents    = row["budget_daily_amount"].to_f * 100
      campaign.daily_budget_currency = "USD"
      campaign.ecpm_cents            = row["ecpm"].to_f * 100
      campaign.ecpm_currency         = "USD"
      campaign.countries             = row["included_countries"][1...-1].split(",").map { |kw| kw.gsub('"', '') }

      programming_languages = row["included_programming_languages"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      topic_categories      = row["included_topic_categories"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      campaign.keywords     = (programming_languages + topic_categories).uniq.compact.sort

      excluded_programming_languages = row["excluded_programming_languages"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      excluded_topic_categories      = row["excluded_topic_categories"][1...-1].split(",").map { |kw| kw.gsub('"', '') }
      campaign.negative_keywords     = (excluded_programming_languages + excluded_topic_categories).uniq.compact.sort
      campaign.created_at            = row["inserted_at"]

      campaign.save!
      print "."
    end

    puts " Done!"
  end
  
end