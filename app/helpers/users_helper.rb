module UsersHelper
  def user_tabs(user)
    [
      {name: "Overview", path: user_path(user), active: :exact},
      {name: "Properties", path: user_properties_path(user), validation: user.properties.exists?},
      {name: "Campaigns", path: user_campaigns_path(user), validation: user.campaigns.exists?},
      {name: "Emails", path: user_emails_path(user), validation: authorized_user.can_view_emails?},
      {name: "Comments", path: user_comments_path(user), validation: authorized_user.can_view_comments?},
      {name: "Settings", path: edit_user_path(user)}
    ]
  end

  def default_dashboard_path(user)
    return administrator_dashboards_path if user.has_role?("administrator")
    return advertiser_dashboards_path if user.has_role?("advertiser")
    return publisher_dashboards_path if user.has_role?("publisher")
    manage_job_postings_path
  end
end
