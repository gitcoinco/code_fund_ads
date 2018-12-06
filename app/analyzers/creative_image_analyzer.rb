class CreativeImageAnalyzer < ActiveStorage::Analyzer::ImageAnalyzer
  def metadata
    md = super.dup
    md[:name]   = @blob.filename
    md[:format] = "small" if md[:width] == 200 && md[:height] == 200
    md[:format] = "large" if md[:width] == 260 && md[:height] == 200
    md[:format] = "wide"  if md[:width] == 512 && md[:height] == 360
    md
  end
end