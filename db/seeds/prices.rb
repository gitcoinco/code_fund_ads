ActiveRecord::Base.transaction do
  pricing_plan = PricingPlan.first_or_create!(name: "2020, 2nd Quarter")
  Price.where(pricing_plan: pricing_plan).delete_all

  Audience.all.each do |audience|
    Region.all.each do |region|
      Price.create!(
        pricing_plan: pricing_plan,
        audience: audience,
        region: region,
        cpm: audience.ecpm_for_region(region),
        rpm: audience.ecpm_for_region(region) * 0.7
      )
    end
  end
end
