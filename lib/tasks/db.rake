namespace :db do
  desc "Dumps the development database to ./tmp/..."
  task dump: [:environment] do
    return puts("Only run in the development environment!") unless Rails.env.development?
    config = ActiveRecord::Base.connection_config
    path = Rails.root.join("tmp", "#{config[:database]}.dump")
    puts "Dumping database [#{config[:database]}] to #{path}"
    if config[:username] && config[:password]
      exec "pg_dump --verbose -Fc --no-acl --no-owner -h #{config[:host]} -U #{config[:username]} #{config[:database]} > #{path}"
    else
      exec "pg_dump --verbose -Fc --no-acl --no-owner -h #{config[:host]} #{config[:database]} > #{path}"
    end
  end

  desc "Restores the development database from the dump file in ./tmp"
  task restore: [:environment] do
    return puts("Only run in the development environment!") unless Rails.env.development?
    config = ActiveRecord::Base.connection_config
    path = Rails.root.join("tmp", "#{config[:database]}.dump")
    puts "Restoring database [#{config[:database]}] from #{path}"
    return puts("#{path} does not exist!") unless File.exist?(path)
    if config[:username] && config[:password]
      exec "pg_restore --verbose --clean --no-acl --no-owner -h #{config[:host]} -U #{config[:username]} -d #{config[:database]} #{path}"
    else
      exec "pg_restore --verbose --clean --no-acl --no-owner -h #{config[:host]} -d #{config[:database]} #{path}"
    end
  end

  desc "Reset postgres pk sequence id's on all tables"
  task seq_ids_reset: [:environment] do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
