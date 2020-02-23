module PropertyIdExtractor
  def self.extract_property_id(path)
    if /\/funder/.match?(path)
      path.scan(/(?<=\/properties\/)[0-9a-z-]+(?=\/funder.*)/i).first
    elsif /\/embed/.match?(path)
      path.scan(/(?<=\/scripts\/)[0-9a-z-]+(?=\/embed.*)/i).first
    elsif /\/t\/s\//.match?(path)
      path.scan(/(?<=\/t\/s\/)[0-9a-z-]+(?=\/details.*)/i).first
    elsif /\/api\/v1\/impression\//.match?(path)
      path.scan(/(?<=\/api\/v1\/impression\/)[0-9a-z-]+(?=\/|\?|\z)/i).first
    end
  end
end
