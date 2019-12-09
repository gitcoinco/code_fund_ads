json.key_format! camelize: :lower # TODO: remove this line in favor of global setting at config/jbuilder.rb after legacy support has been removed on 2019-04-01
if @campaign
  json.campaign_url @campaign_url
  json.impression_url @impression_url
  json.codefund_url "https://app.codefund.io"
  json.fallback @campaign.fallback?
  json.headline @campaign.creative.sanitized_headline
  json.body @campaign.creative.sanitized_body
  json.images do
    json.partial! "/advertisements/image", collection: @campaign.creative.images, as: :image
  end
  json.html interpolated_advertisement_html
else
  json.message "CodeFund does not have an advertiser for you at this time."
end
