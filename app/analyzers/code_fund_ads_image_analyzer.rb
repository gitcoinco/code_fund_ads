class CodeFundAdsImageAnalyzer < ActiveStorage::Analyzer::ImageAnalyzer
  attr_reader :new_metadata

  def metadata
    @new_metadata = super.dup
    new_metadata[:name] = @blob.filename
    new_metadata[:format] = @blob.svg? ? analyze_svg : analyze
    new_metadata[:format] ||= ENUMS::IMAGE_FORMATS::UNKNOWN
    new_metadata
  end

  private

  def analyze
    return nil unless new_metadata[:height].present? && new_metadata[:width].present?
    size = "#{new_metadata[:width]}x#{new_metadata[:height]}"
    case size
    when "20x20", "40x40" then ENUMS::IMAGE_FORMATS::ICON
    when "200x200" then ENUMS::IMAGE_FORMATS::SMALL
    when "260x200" then ENUMS::IMAGE_FORMATS::LARGE
    when "512x320" then ENUMS::IMAGE_FORMATS::WIDE
    end
  end

  def analyze_svg
    return nil unless new_metadata[:height].present? && new_metadata[:width].present?
    size = "#{new_metadata[:width]}x#{new_metadata[:height]}"
    return ENUMS::IMAGE_FORMATS::SPONSOR if size == "400x40"
    CreateSponsorSvgJob.perform_later @blob
    nil
  end
end
