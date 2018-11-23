with aggregate_impressions as (
  select count(*),
  count(*) filter (where clicked_at is not null) as click_count,
  campaign_name,
  property_name
  from impressions
  where {{displayed_at_date}}
  [[and {{country_code}}]]
  group by campaign_name, property_name
)

select
campaign_name,
property_name,
count,
click_count,
(click_count / count::decimal) * 100 as click_rate
from aggregate_impressions
order by click_rate
