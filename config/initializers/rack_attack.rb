bad_actor_ip_addresses = %w[
  164.163.204.112
]

# Block known bad actors
bad_actor_ip_addresses.each do |ip_address|
  Rack::Attack.blocklist_ip ip_address
end

# Block IPs that attempt SQL injection
Rack::Attack.blocklist("sql-injection") do |request|
  Rack::Attack::Fail2Ban.filter("sql-injection-#{request.ip}", maxretry: 1, findtime: 1.hour, bantime: 1.day) do
    path = CGI.unescape(request.path).downcase
    (path.include?("truncate") && path.include?("table")) ||
      (path.include?("drop") && path.include?("table")) ||
      (path.include?("insert") && path.include?("into")) ||
      (path.include?("update") && path.include?("set")) ||
      (path.include?("select") && path.include?("from"))
  end
end

if Rails.env.production?
  # Throttle all IPs to 20 requests/minute
  Rack::Attack.throttle("requests by ip", limit: 20, period: 1.minute.to_i) do |request|
    request.ip
  end

  # Throttle ads per property to 120/minute i.e. max of 172,800/day
  Rack::Attack.throttle("limit logins per email", limit: 120, period: 1.minute.to_i) do |req|
    PropertyIdExtractor.extract_property_id req.path
  end
end
