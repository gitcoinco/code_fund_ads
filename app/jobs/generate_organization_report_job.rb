class GenerateOrganizationReportJob < ApplicationJob
  queue_as :default

  def self.doc_raptor
    @doc_raptor ||= DocRaptor::DocApi.new
  end

  delegate :doc_raptor, to: :"self.class"

  def perform(id:, report_url:)
    organization_report = OrganizationReport.find_by(id: id)
    return unless organization_report

    organization_report.update(status: "generating")
    begin
      filename = "organization-report-#{organization_report.organization_id}-#{organization_report.id}.pdf"

      response = doc_raptor.create_doc(
        test: Rails.env.development?,
        document_url: report_url,
        name: filename,
        document_type: "pdf",
        javascript: true
      )

      tempfile = Tempfile.new(filename)
      tempfile.binmode
      tempfile.write(response)
      tempfile.rewind

      organization_report.pdf.attach(io: tempfile, filename: filename, content_type: "application/pdf")
      organization_report.update(status: "ready")
    rescue => ex
      Rails.logger.error(ex)
      organization_report.update(status: "error")
    ensure
      tempfile.close
    end
  end
end
