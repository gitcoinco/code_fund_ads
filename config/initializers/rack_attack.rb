bad_actor_ip_addresses = %w[
  164.163.204.112
]

bad_actor_ip_addresses.each do |ip_address|
  Rack::Attack.blocklist_ip ip_address
end

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
