web: bin/start-pgbouncer bundle exec puma -C config/puma.rb
worker: bin/start-pgbouncer bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate
