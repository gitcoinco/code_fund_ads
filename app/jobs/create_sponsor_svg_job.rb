class CreateSponsorSvgJob < ApplicationJob
  queue_as :low

  def perform(blob)
    return unless blob.svg?
    return if blob.metadata[:format] == ENUMS::IMAGE_FORMATS::SPONSOR

    users = blob.attachments.where(record_type: "User").map(&:record)
    sponsor_svg = SvgsController.render(partial: "/svgs/sponsors/default", locals: {logo: embedded_svg(blob).html_safe})
    filename = "sponsor-#{blob.filename.base}.svg"
    Tempfile.open(filename, Rails.root.join("tmp")) do |file|
      file.write sponsor_svg
      users.each do |user|
        file.rewind
        next if user.images.search_filename(filename).present?
        user.images.attach sponsor_svg_options(io: file, filename: filename)
      end
    end
  end

  private

  def sponsor_svg_options(io:, filename:)
    {
      io: io,
      filename: filename,
      content_type: "image/svg+xml",
      metadata: {
        identified: true,
        width: 400,
        height: 40,
        analyzed: true,
        name: filename,
        format: ENUMS::IMAGE_FORMATS::SPONSOR
      }
    }
  end

  def embedded_svg(blob)
    svg = Nokogiri::XML(blob.download).css("svg").first
    svg.set_attribute "width", "auto"
    svg.set_attribute "height", 24
    svg.set_attribute "x", 120
    svg.set_attribute "y", 7
    svg.set_attribute "preserveAspectRatio", "xMinYMid meet"
    svg.to_s
  end
end
