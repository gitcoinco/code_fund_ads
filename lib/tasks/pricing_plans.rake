namespace :pricing_plans do
  task list: :environment do
    PricingPlan.order(created_at: :desc).each do |plan|
      puts "#{plan.id.to_s.rjust 4}: #{plan.name}"
    end
  end
end
