class OrganizationReportsReflex < ApplicationReflex
  def generate
    CreateOrganizationReportJob.perform_later(id: element.dataset[:id])
  end
end
