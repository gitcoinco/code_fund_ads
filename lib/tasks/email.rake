namespace :email do
  desc "Remove unwanted emails"
  task remove_unwanted_emails: :environment do
    Email.all.each do |email|
      next if email.users.non_administrators.count > 0
      email.destroy
    end
  end

  desc "Remove duplicate emails"
  task remove_duplicate_emails: :environment do
    sql = <<~SQL
      SELECT id FROM
        (SELECT id, ROW_NUMBER() OVER (PARTITION BY message_id ORDER BY id) AS row_num FROM emails) t
      WHERE t.row_num > 1
    SQL
    duplicate_email_ids = ActiveRecord::Base.connection.execute(sql).values.flatten
    Email.where(id: duplicate_email_ids).destroy_all
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

    Email.rebuild! # Rebuild heirarchies
  end
end