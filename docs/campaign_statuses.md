# Campaign Statuses

Campaign statuses are defined in config/enums.yml

- `CAMPAIGN_STATUSES`
- `STATUS_COLORS`

## accepted

  - Approved
  - Expected to become active
  - Not fully configured i.e. missing creatives etc...
  - Included when determining sold inventory

## active

  - Approved
  - Fully configured
  - Available to show ads based on start and end dates
  - Included when determining sold inventory

## archived

  - No longer in use
  - Not included when determining sold inventory

## paused

  - Approved
  - Fully configured
  - Will not show ads
  - Included when determining sold inventory
  - Only active campaigns can be put into this state

## pending

  - Not approved
  - May never become active
  - Not fully configured i.e. missing creatives etc...
  - Not included when determining sold inventory
