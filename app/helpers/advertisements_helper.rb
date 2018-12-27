module AdvertisementsHelper
  def interpolated_advertisement_html(html, impression_url, campaign_url)
    fragment = Nokogiri::HTML::DocumentFragment.parse(html)

    fragment.css('img[data-src="impression_url"]').each do |img|
      img["src"] = impression_url
      img.remove_attribute "data-src"
    end

    fragment.css('a[data-href="campaign_url"]').each do |a|
      a["href"] = campaign_url
      a.remove_attribute "data-href"
    end

    fragment.to_html
  end
end
