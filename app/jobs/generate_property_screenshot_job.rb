class GeneratePropertyScreenshotJob < ApplicationJob
  queue_as :default

  def perform(property_id)
    property = Property.find(property_id)

    sm = ScreenshotMachine.new(property.url)

    tempfile = Tempfile.new("fileupload")
    tempfile.binmode
    tempfile.write(sm.screenshot)
    tempfile.rewind

    uploaded_file = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: "property-screenshot-#{property.id}.jpg", type: "image/jpeg")

    property.screenshot = uploaded_file
    property.save!
  end
end
