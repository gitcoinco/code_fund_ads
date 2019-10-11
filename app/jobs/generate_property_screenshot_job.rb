class GeneratePropertyScreenshotJob < ApplicationJob
  queue_as :default

  def perform(property_id)
    return if Rails.env.development?

    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    return unless ENV["SCREENSHOT_MACHINE_KEY"]

    property = Property.find_by(id: property_id)
    return unless property

    sm = ScreenshotMachine.new(property.url)

    tempfile = Tempfile.new("fileupload")
    tempfile.binmode
    tempfile.write(sm.screenshot)
    tempfile.rewind

    uploaded_file = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: "property-screenshot-#{property.id}.jpg", type: "image/jpeg")

    property.screenshot = uploaded_file
    property.save!

    property.add_event("Captured new screenshot", ["screenshot"])
  end
end
