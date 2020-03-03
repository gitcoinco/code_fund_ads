module AdvertisementsHelper
  def interpolated_advertisement_html
    template = Rails.application.config.ad_templates[template_name]
    stylesheet = tag.link(href: asset_pack_url("code_fund_ad.css"), rel: "stylesheet", media: "all")
    options = advertisement_mustache_template_options
    options[:urls][:instantImpression] = options[:urls][:impression]
    html = Mustache.render(template, options)
    [stylesheet, html].join
  end

  def advertisement_mustache_template_options
    {
      selector: "##{@target || "codefund"}",
      template: template_name,
      theme: theme_name,
      fallback: !!@campaign&.fallback?,
      urls: {
        impression: @impression_url.to_s.strip,
        campaign: @campaign_url.to_s.strip,
        poweredBy: @powered_by_url.to_s.strip,
        adblock: ENV["ADBLOCK_PLUS_PIXEL_URL"].to_s.strip,
        uplift: @uplift_url.to_s.strip
      },
      creative: {
        name: @creative&.name,
        headline: @creative&.headline,
        body: @creative&.body,
        cta: @creative&.cta || "Learn more",
        imageUrls: {
          icon: @creative&.icon_image&.cloudfront_url,
          small: @creative&.small_image&.cloudfront_url,
          large: @creative&.large_image&.cloudfront_url,
          wide: @creative&.wide_image&.cloudfront_url
        }
      }
    }
  end
end
