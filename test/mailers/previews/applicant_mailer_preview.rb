# Preview all emails at http://localhost:3000/rails/mailers/applicant_mailer
class ApplicantMailerPreview < ActionMailer::Preview
  def advertiser_application_email
    ApplicantMailer.with(form: {
      first_name: "Connor",
      last_name: "Linsley",
      company_name: "ACME, Inc",
      company_url: "https://example.com",
      email: "connor.linsley@example.com",
      monthly_budget: "$1,000 - $2,499",
    }).advertiser_application_email
  end

  def publisher_application_email
    ApplicantMailer.with(form: {
      first_name: "Connor",
      last_name: "Linsley",
      website_url: "https://example.com",
      email: "connor.linsley@example.com",
      monthly_visitors: "10,000 - 50,000",
    }).publisher_application_email
  end
end
