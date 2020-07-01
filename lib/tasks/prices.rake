namespace :prices do
  task :create_csv, [:pricing_plan_id] => :environment do |t, args|
    plan = PricingPlan.find(args[:pricing_plan_id])

    CSV.open Rails.root.join("tmp/pricing_plan_#{plan.id}.csv"), "wb" do |csv|
      csv << %w[audience region cpm rpm avg_rpm_last_30]

      Audience.all.each do |audience|
        Region.all.each do |region|
          price = plan.prices.find_by(audience: audience, region: region)
          rpms = Property.active.where(audience: audience).map { |property|
            property.average_rpm_by_region(30.days.ago, 1.day.ago)[region]
          }
          rpms = rpms.compact.select { |rpm| rpm > 0 }
          avg_rpm_last_30 = rpms.size > 0 ? (rpms.sum / rpms.size) : Money.new(0, "USD")

          csv << [
            audience.name,
            region.name,
            price.cpm.format,
            price.rpm.format,
            avg_rpm_last_30.format
          ]
        end
      end
    end
  end
end
