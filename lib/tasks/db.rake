namespace :db do
  namespace :migrate do
    desc <<~DESC
      Inserts the shotgun migration version into the schema_migrations table

      Supports pointing at an existing database with pre-defined schema
    DESC
    task skip_shotgun: :environment do
      ActiveRecord::Base.connection.execute <<~SQL
      INSERT INTO schema_migrations
      (version, inserted_at) VALUES('20181017152837', now())
      SQL
    end
  end
end
