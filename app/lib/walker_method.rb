# SEE: https://en.wikipedia.org/wiki/Alias_method
# THANKS: https://github.com/cantino/walker_method
class WalkerMethod
  attr_accessor :items, :probabilities, :aliases, :length

  def initialize(items, weights)
    @items = items
    @length = weights.length
    @probabilities = []
    @aliases = Array.new(length, -1)

    under = []
    over = []

    total = weights.sum.to_f
    weights.each do |w|
      probabilities << w * length / total
    end

    probabilities.each.with_index do |p, index|
      under << index if p < 1
      over << index if p > 1
    end

    while under.length > 0 && over.length > 0
      u = under.pop
      o = over[-1]
      aliases[u] = o
      probabilities[o] -= (1 - probabilities[u])
      if probabilities[o] < 1
        under << o
        over.pop
      end
    end
  end

  def random
    n = (rand * length).to_i
    return items[n] if rand <= probabilities[n]
    items[aliases[n]]
  end
end
