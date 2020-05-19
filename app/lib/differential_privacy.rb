module DifferentialPrivacy
  def self.flip(value, substitute)
    return value if rand(2) == 0 # first flip
    rand(2) == 0 ? value : substitute # second flip
  end
end
