SitemapGenerator::Sitemap.default_host = "https://app.codefund.io"
SitemapGenerator::Sitemap.verbose = true
SitemapGenerator::Sitemap.create do
  add root_path, priority: 0.9, changefreq: "weekly"
end
