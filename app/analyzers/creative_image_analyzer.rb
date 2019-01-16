class CreativeImageAnalyzer < ActiveStorage::Analyzer::ImageAnalyzer
  def metadata
    md = super.dup
    md[:name] = @blob.filename
    return md unless md[:height].present? && md[:width].present?

    md[:format] = "small" if (md[:width] / md[:height].to_f) == (200 / 200.to_f)
    md[:format] = "large" if (md[:width] / md[:height].to_f) == (260 / 200.to_f)
    md[:format] = "wide"  if (md[:width] / md[:height].to_f) == (512 / 360.to_f)
    md
  end
end
