namespace :email do
  desc "Remove unwanted emails"
  task remove_unwanted_emails: :environment do
    STDOUT.puts "Calculating unwanted emails ..."
    destroyable_ids = []

    Email.all.each do |email|
      next if email.users.non_administrators.count > 0
      destroyable_ids << email.id
    end

    STDOUT.puts "Are you sure you want to delete #{destroyable_ids.count} emails (out of #{Email.count})? (y/N)"
    input = STDIN.gets.strip

    if input == "y"
      STDOUT.print "Deleting..."
      Email.where(id: destroyable_ids).destroy_all
      STDOUT.puts "Done!"
    else
      STDOUT.puts "👍"
    end
  end

  desc "Apply threading to existing emails"
  task apply_email_threading: :environment do
    Email.all.each do |email|
      mail = email.inbound_email.mail
      email.message_id = mail.message_id
      email.in_reply_to = mail.in_reply_to
      if mail.in_reply_to.present?
        parent_email = Email.find_by(message_id: mail.in_reply_to)
        email.parent_id = parent_email&.id
      end
      email.save
    end
    puts "Updated #{Email.count} emails"

    Email.rebuild! # Rebuild heirarchies
  end

  desc "Remove duplicate emails"
  task remove_duplicate_emails: :environment do
    STDOUT.puts "Did you already apply threading? (y|N)"
    input = STDIN.gets.strip
    if input != "y"
      abort "You must first run `rails email:apply_email_threading` before running this method"
    end

    STDOUT.puts "Calculating duplicate emails ..."
    sql = <<~SQL
      SELECT id FROM
        (SELECT id, ROW_NUMBER() OVER (PARTITION BY message_id ORDER BY id) AS row_num FROM emails) t
      WHERE t.row_num > 1
    SQL
    duplicate_email_ids = ActiveRecord::Base.connection.execute(sql).values.flatten.compact.uniq

    STDOUT.puts "Are you sure you want to delete #{duplicate_email_ids.count} emails (out of #{Email.count})? (y/N)"
    input = STDIN.gets.strip

    if input == "y"
      STDOUT.print "Deleting..."
      Email.where(id: duplicate_email_ids).destroy_all
      STDOUT.puts "Done!"
    else
      STDOUT.puts "👍"
    end
  end
end
