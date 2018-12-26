if @advertisement_html
  json.html interpolated_advertisement_html(@advertisement_html, @impression_url, @campaign_url)
else
  json.message "CodeFund does not have a advertiser for you at this time."
end
