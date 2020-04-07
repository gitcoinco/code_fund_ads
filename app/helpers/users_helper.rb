module UsersHelper
  def default_dashboard_path(user)
    return administrator_dashboards_path if user.has_role?("administrator")
    return advertiser_dashboards_path if user.has_role?("advertiser")
    return publisher_dashboards_path if user.has_role?("publisher")
    manage_job_postings_path
  end
end
