namespace :datastore_connections do
  desc "Prints the datastore connections that will be attempted based on ENV config."
  task :print, [:web_dynos, :worker_dynos] => [:environment] do |t, args|
    WEB_DYNOS = (args["web_dynos"] || 1).to_i
    WORKER_DYNOS = (args["worker_dynos"] || 1).to_i
    PGBOUNCER_MAX_CLIENT_CONN = ENV.fetch("PGBOUNCER_MAX_CLIENT_CONN", "100").to_i
    WEB_CONCURRENCY = ENV.fetch("WEB_CONCURRENCY", 3).to_i
    RAILS_MAX_THREADS = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
    ACTION_CABLE_MAX_THREADS = ENV.fetch("ACTION_CABLE_MAX_THREADS", 10).to_i
    REDIS_CACHE_MAX_THREADS = ENV.fetch("REDIS_MAX_THREADS", 10).to_i
    REDIS_QUEUE_MAX_THREADS = ENV.fetch("REDIS_MAX_THREADS", 10).to_i
    SIDEKIQ_CONCURRENCY = REDIS_CACHE_MAX_THREADS - 2

    puts
    puts "Connections that will be established under the current settings."
    puts "Be sure tha these numbers are under the maximum allowed"
    puts

    web = WEB_CONCURRENCY * RAILS_MAX_THREADS
    worker = WEB_CONCURRENCY * SIDEKIQ_CONCURRENCY
    puts "PostgreSQL"
    puts "Max (per dyno) ......#{PGBOUNCER_MAX_CLIENT_CONN}"
    puts "Web (per dyno).......#{web}"
    puts "Worker (per dyno) ...#{worker}"
    puts

    web = WEB_CONCURRENCY * REDIS_CACHE_MAX_THREADS
    puts "Redis Cache"
    puts "Max: 512 (check current plan)"
    puts "Web (per dyno) ....#{web}"
    puts "Web (all dynos) ...#{WEB_DYNOS * web}"
    puts

    web = (WEB_CONCURRENCY * REDIS_QUEUE_MAX_THREADS) + (WEB_CONCURRENCY * ACTION_CABLE_MAX_THREADS)
    worker = WEB_CONCURRENCY * REDIS_QUEUE_MAX_THREADS
    puts "Redis Queue"
    puts "Max: 1024 (check current plan)"
    puts "Web (per dyno) .......#{web}"
    puts "Web (all dynos) ......#{WEB_DYNOS * web}"
    puts "Worker (per dyno) ....#{worker}"
    puts "Worker (all dynos) ...#{WORKER_DYNOS * worker}"
    puts "Total ................#{(WEB_DYNOS * web) + (WORKER_DYNOS * worker)}"
    puts
  end
end
