web: bin/start-nginx bundle exec puma -C config/puma.rb
worker: bin/start-pgbouncer-stunnel bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate
