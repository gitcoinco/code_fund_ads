with aggregate_impressions as (
  select count(*),
  count(*) filter (where clicked_at is not null) as click_count,
  country_code,
  property_name
  from impressions
  where {{displayed_at_date}}
  and {{campaign_name}}
  group by country_code, property_name
)

select
country_code,
property_name,
count,
click_count,
(click_count / count::decimal) * 100 as click_rate
from aggregate_impressions
order by country_code, click_rate
