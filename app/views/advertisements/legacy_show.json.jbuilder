# legacy api support
# TODO: deprecate legacy support on 2019-04-01
if @campaign
  json.description @campaign.creative.body
  json.headline @campaign.creative.headline
  json.large_image_url @campaign.creative.large_image&.cloudfront_url
  json.reason nil
  json.images do
    json.partial! "/advertisements/legacy_image", collection: @campaign.creative.images, as: :image
  end
  json.link  @campaign_url
  json.pixel @impression_url
  json.poweredByLink "https://codefund.app"
  json.small_image_url @campaign.creative.small_image&.cloudfront_url
  json.house_ad @campaign.fallback?
else
  json.small_image_url ""
  json.reason "CodeFund does not have a advertiser for you at this time."
  json.poweredByLink "https://codefund.app"
  json.pixel ""
  json.link ""
  json.large_image_url ""
  json.images []
  json.house_ad false
  json.headline ""
  json.description ""
end
