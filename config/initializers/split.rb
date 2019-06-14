Split.configure do |config|
  config.algorithm = Split::Algorithms::Whiplash # multi-armed bandit
  config.winning_alternative_recalculation_interval = 3600 # 1 hour
end
