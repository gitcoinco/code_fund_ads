with data as (
  select
  advertiser_id,
  campaign_id,
  creative_id,
  publisher_id,
  property_id,
  count(*) impression_count,
  count(*) filter (where clicked_at_date is not null) as click_count,
  sum(estimated_gross_revenue_fractional_cents) / 100 as estimated_gross_revenue,
  sum(estimated_property_revenue_fractional_cents) / 100 as estimated_property_revenue,
  sum(estimated_house_revenue_fractional_cents) / 100 as estimated_house_revenue
  from impressions
  where {{displayed_at_date}}
  [[and {{advertiser_id}}]]
  [[and {{campaign_id}}]]
  [[and {{publisher_id}}]]
  [[and {{property_id}}]]
  group by advertiser_id, campaign_id, creative_id, publisher_id, property_id
)

select
(select email from users where id = data.advertiser_id) as advertiser,
(select name from campaigns where id = data.campaign_id) as campaign,
(select name from creatives where id = data.creative_id) as creative,
(select email from users where id = data.publisher_id) as publisher,
(select url from properties where id = data.property_id) as property,
impression_count,
click_count,
(click_count / impression_count::decimal) * 100 as click_rate,
estimated_gross_revenue,
estimated_property_revenue,
estimated_house_revenue
from data
union all
select
null,
null,
null,
null,
'TOTALS',
sum(impression_count),
sum(click_count), (sum(click_count) / sum(impression_count)) * 100,
sum(estimated_gross_revenue),
sum(estimated_property_revenue),
sum(estimated_house_revenue)
from data
order by impression_count desc
