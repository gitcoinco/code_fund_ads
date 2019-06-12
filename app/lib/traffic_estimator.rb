module TrafficEstimator
  class << self
    def lookup(host)
      sanitized_host = sanitize_host(host)
      url = request_url(sanitized_host)
      results = Typhoeus.get(url, followlocation: true)
      JSON.parse(results.response_body).with_indifferent_access
    end

    private

    def request_url(host)
      "https://endpoint.sitetrafficapi.com/pay-as-you-go/?key=#{ENV["SITE_TRAFFIC_API_KEY"]}&host=#{host}"
    end

    def sanitize_host(host)
      host = "https://#{host}" unless host.include?("http")
      uri = URI(host)
      uri.host
    end
  end
end
