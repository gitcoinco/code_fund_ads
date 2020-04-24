namespace :misc do
  desc "Generate the link to use with SendGrid Inbound Parser"
  task generate_inbound_destination_url: :environment do
    puts "https://actionmailbox:#{ENV['RAILS_INBOUND_EMAIL_PASSWORD']}@#{ENV['NGROK_HOST']}/rails/action_mailbox/sendgrid/inbound_emails"
  end
end