# Preview all emails at http://localhost:3000/rails/mailers/applicant_mailer
class ApplicantMailerPreview < ActionMailer::Preview
  def advertiser_application_email
    ApplicantMailer.with(form: {
      first_name: "Connor",
      last_name: "Linsley",
      company_name: "ACME, Inc",
      company_url: "https://example.com",
      email: "connor.linsley@example.com",
      monthly_budget: "1000-2499"
    }).advertiser_application_email
  end
end
