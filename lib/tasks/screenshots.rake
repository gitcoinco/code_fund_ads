namespace :screenshots do
  desc "Regenerate all missing screenshots"
  task regenerate: :environment do
    Property.all.each do |property|
      GeneratePropertyScreenshotJob.perform_later(property.id) unless property.screenshot.attached?
    end
    puts "Done!"
  end
end
