namespace :data do
  namespace :publishers do
    task :purge, [:user_id] => [:environment] do |_task, args|
      user = User.publishers.find_by(id: args[:user_id])
      exit_early "User not found" unless user

      puts "Are you sure you want to delete user #{user.id}: #{user.full_name} <#{user.email}>? [y/N]"
      puts "This cannot be undone!"
      exit_early "No action taken" unless yes?

      puts "Do you want to delete all of their properties? [y/N]"
      puts "This cannot be undone!"
      if yes?
        user.properties.each do |property|
          puts "Deleting property #{property.id}: #{property.name} <#{property.url}>"
          property.destroy!
        end
      end

      puts "Deleting user #{user.id}: #{user.full_name} <#{user.email}>"
      user.destroy!
    end
  end

  private

  def yes?
    !!(STDIN.gets.strip =~ /\Ay\z/i)
  end

  def exit_early(message)
    puts message
    exit 0
  end
end
