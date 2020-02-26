web: bin/start-pgbouncer-stunnel bin/start-nginx bundle exec puma -C config/puma.rb
worker: bin/start-pgbouncer-stunnel bundle exec sidekiq -C config/sidekiq.yml
worker_daily_summaries: bin/start-pgbouncer-stunnel bundle exec sidekiq -C config/sidekiq_daily_summaries.yml
release: bundle exec rails db:migrate
