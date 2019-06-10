SitemapGenerator::Sitemap.default_host = "https://codefund.io"
SitemapGenerator::Sitemap.verbose = true
SitemapGenerator::Sitemap.create do
  add root_path, priority: 0.9, changefreq: "weekly"
  add publishers_path, priority: 0.8, changefreq: "monthly"
  add advertisers_path, priority: 0.8, changefreq: "monthly"
  add pricing_path, priority: 0.7, changefreq: "monthly"
  add buttercms_blog_rss_path, priority: 0.6, changefreq: "weekly"
  add buttercms_blog_atom_path, priority: 0.6, changefreq: "weekly"
  add buttercms_blog_path, priority: 0.6, changefreq: "weekly"
  ButterCMS::Post.all.each do |post|
    add buttercms_post_path(post.slug), news: {
      publication_name: "CodeFund Blog",
      publication_language: "en",
      title: post.data.title,
      publication_date: post.data.published,
    }
  end
end
