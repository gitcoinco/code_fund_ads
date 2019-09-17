class GenerateOrganizationReportJob < ApplicationJob
  queue_as :default

  def perform(organization_report_id)
    organization_report = OrganizationReport.find(organization_report_id)
    filename = "organization-report-#{organization_report.organization_id}-#{organization_report.id}.pdf"

    url_options = Rails.configuration.action_mailer.default_url_options
    document_url = Rails.application.routes.url_helpers.organization_report_url(organization_report.organization, organization_report.id, url_options)

    response = $docraptor.create_doc(
      test: Rails.env.development?,
      document_url: document_url,
      name: filename,
      document_type: "pdf",
      javascript: true
    )

    tempfile = Tempfile.new(filename)
    tempfile.binmode
    tempfile.write(response)
    tempfile.rewind

    organization_report.pdf.attach(io: tempfile, filename: filename, content_type: "application/pdf")
  end
end
