web: bin/start-pgbouncer-stunnel bundle exec puma -C config/puma.rb
worker: bin/start-pgbouncer-stunnel bundle exec sidekiq -v -C config/sidekiq.yml
worker_counters: bin/start-pgbouncer-stunnel bundle exec sidekiq -v -C config/sidekiq_counters.yml
release: bundle exec rails db:migrate
