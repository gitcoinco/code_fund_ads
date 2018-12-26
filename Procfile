web: bin/start-pgbouncer-stunnel bundle exec falcon serve --port 3000
worker: bin/start-pgbouncer-stunnel bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate
