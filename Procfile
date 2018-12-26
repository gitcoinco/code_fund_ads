web: bin/start-pgbouncer-stunnel RACK_HANDLER=falcon bundle exec rails s
worker: bin/start-pgbouncer-stunnel bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate
