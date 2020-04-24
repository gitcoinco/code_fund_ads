require "test_helper"
require "rails/performance_test_help"

class BenchmarksTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = {runs: 5, metrics: [:wall_time, :memory, :objects, :gc_runs, :gc_time],
                          output: "tmp/performance", formats: [:flat]}

  test "index" do
    get "/benchmarks"
  end

  test "components" do
    get "/benchmarks/components"
  end

  test "helpers" do
    get "/benchmarks/helpers"
  end

  test "traditional" do
    get "/benchmarks/traditional"
  end
end

# First run

# BenchmarksTest#test_components (94 ms warmup)
#            wall_time: 17 ms
#               memory: 0 Bytes
#              objects: 7,165
#              gc_runs: 0
#              gc_time: 0 ms
# .BenchmarksTest#test_helpers (8 ms warmup)
#            wall_time: 14 ms
#               memory: 0 Bytes
#              objects: 7,168
#              gc_runs: 0
#              gc_time: 0 ms
# .BenchmarksTest#test_index (8 ms warmup)
#            wall_time: 15 ms
#               memory: 0 Bytes
#              objects: 7,137
#              gc_runs: 0
#              gc_time: 0 ms
# .BenchmarksTest#test_traditional (9 ms warmup)
#            wall_time: 14 ms
#               memory: 0 Bytes
#              objects: 7,164
#              gc_runs: 0
#              gc_time: 0 ms
# .
