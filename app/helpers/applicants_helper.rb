module ApplicantsHelper
  def applicant_status_color(status)
    ENUMS::APPLICANT_STATUS_COLORS[status]
  end
end
