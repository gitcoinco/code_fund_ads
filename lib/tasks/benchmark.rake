require "benchmark"

namespace :benchmark do
  namespace :production do
    task ads: :environment do
      property_ids = Property.active.pluck(:id)
      server_times = []

      puts(
        Benchmark.measure {
          10.times do
            url = "https://app.codefund.io/properties/#{property_ids.sample}/funder.js"
            puts "GET: #{url}"
            response = Typhoeus.get(url)
            server_times << response.headers["X-Runtime"].to_f
            puts "#{response.status_message}: #{response.headers["X-Runtime"]}"
          end
        }
      )

      puts "Min: #{server_times.min.round(2)} secs"
      puts "Max: #{server_times.max.round(2)} secs"
      puts "Avg: #{(server_times.sum / server_times.size).round(2)} secs"
    end
  end
end
