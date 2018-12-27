<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

- [CodeFund Ads](#codefund-ads)
  - [Publisher JavaScript Embedding](#publisher-javascript-embedding)
    - [Optional Query String Parameters](#optional-query-string-parameters)
  - [API](#api)
  - [Ad Rendering and Impression/Click Tracking](#ad-rendering-and-impressionclick-tracking)
  - [Enums](#enums)
  - [Development Environment](#development-environment)
    - [Database Seeds](#database-seeds)
    - [Tmux/Teamocil or Mert](#tmuxteamocil-or-mert)
  - [Code Standards](#code-standards)
  - [Deployment](#deployment)
    - [Preboot](#preboot)
    - [Scheduler](#scheduler)
    - [Database](#database)
  - [Maxmind](#maxmind)
  - [Candidates for GEM extraction](#candidates-for-gem-extraction)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

[![](https://travis-ci.org/gitcoinco/code_fund_ads.svg?branch=master)](https://travis-ci.org/gitcoinco/code_fund_ads#)

# CodeFund Ads

CodeFund Ads is an ethical and discreet ad platform that funds open-source.
It helps your favorite projects thrive by paying maintainers the majority of all generated revenue.

## Publisher JavaScript Embedding

After being approved on the CodeFund platform,
publishers can add CodeFund to their site by including the CodeFund script and adding the CodeFund `div`.

```html
<div id="codefund"></div>
<script src="https://codefund.app/properties/PROPERTY_ID/funder.js" async="async" type="text/javascript"></script>
```

### Optional Query String Parameters

- `template` - the template to use _overrides the property config_
- `theme` - the theme to use _overrides the property config_
- `keywords` - the keywords to use for targeting (comma delimited string) _overrides the property config_

> Setting `async` on the script tag will ensure that CodeFund doens't block anything on the publisher's site.

## API

The API is documented with a [Blueprint](https://apiblueprint.org) markdown.

https://github.com/gitcoinco/code_fund_ads/blob/master/BLUEPRINT.md

The official documentation is currently hosted at [Apiary](https://codefund.docs.apiary.io/#).

> NOTE: Apairy doesn't fully adhere to the [Blueprint 1A9 specification](https://github.com/apiaryio/api-blueprint/blob/format-1A9/API%20Blueprint%20Specification.md).
> Our Blueprint file may deviate from the spec to satisfy Apiary limitations.

## Ad Rendering and Impression/Click Tracking

The URLs/routes responsible for ad rendering are:

- **GET** `/properties/1/funder.js` → `advertisements#show` - _embed script_

  This is the embed JavaScript that publishers place on their site.
  It includes the ad HTML and some logic to inject the HTML to the page and setup the links and impression pixel.

- **GET** `/scripts/76bfe997-898a-418c-8f0b-6298b7dd320a/embed.js` → `advertisements#show` - _embed script_

  This endpoint is to support our legacy system (CodeFund v1) embed URLs.
  It points to the same endpoint as `/properties/1/funder.js`.

- **GET** `/display/76bfe997-898a-418c-8f0b-6298b7dd320a.gif` → `impressions#show` - _creates an impression_

  This is the impression pixel image.
  The impression is created after this image is requested and served successfully.
  This means that a matching campaign was found and the embed JavaScript did its job correctly.

- **GET** `/impressions/76bfe997-898a-418c-8f0b-6298b7dd320a/click?campaign_id=1` → `advertisement_clicks#show` - _creates a click_

  This is the proxy/redirect URL that allows us to track the click.
  We immediately redirect to the advertiser's campaign URL and background the work to mark the associated impression as clicked.

## Enums

All enum values are managed as constants defined in `config/enums.yml`
This file is converted to Ruby constants at runtime.

Introspect what enums are defined via the cli.

```ruby
ENUMS.constants
ENUMS::USER_ROLES.constants
# etc...
```

**Always use enums instead of "magic" values.**

## Development Environment

```sh
git clone https://github.com/gitcoinco/code_fund_ads.git
cd /path/to/project
cp .env-sample .env

# setup environment variables

bundle install
yarn install
bundle exec rails db:setup
```

It is recommended to develop with Rails cache enabled. This application relies heavily
on cacheing and may not work properly without the cache enabled.

```sh
bundle exec rails dev:cache
# => Development mode is now being cached.
```

### Database Seeds

The `impressions` table will seed with approximately 100k records spread over 12 months by default.
You can increase this by setting the `IMPRESSIONS` environment variable and seeding again.

```
IMPRESSIONS=10_000_000 rails db:seed
```

### Tmux/Teamocil or Mert

You may want to create a [teamocil](https://github.com/remiprev/teamocil)/[tmux](https://github.com/tmux/tmux) config for your machine.

SEE: https://github.com/gitcoinco/code_fund_ads/blob/master/.teamocil-example.yml

```sh
cd /path/to/project
./bin/teamocil
```

Alternatively, you may want to create a [mert](https://github.com/eggplanetio/mert) config for your machine to be used with iTerm.

SEE: https://github.com/gitcoinco/code_fund_ads/blob/master/.mert-example.yml

```sh
cd /path/to/project
./bin/mert
```

## Code Standards

We avoid [bike shedding](https://en.wikipedia.org/wiki/Law_of_triviality) by enforcing coding standards through tooling.

- Ruby - [standard](https://github.com/testdouble/standard)
- JavaScript - [prettier](https://github.com/prettier/prettier)

Ensure the code has been standardized by running the following before you commit.

```sh
./bin/standardize
```

## Deployment

All pushes of master to Github result in a deployment to the staging environment.
We use Herou build pipelines to promote the deployment to environments like production.

```
./bin/heroku_promote
```

### Preboot

The application is configured for zero downtime deployments using [Heroku's preboot](https://devcenter.heroku.com/articles/preboot) feature.

This means that 2 versions of the application will be running simultaneously during deploys.
All code changes should consider this deployment requirement to ensure that both versions of the app are valid and can run in parallel.

If breaking changes are unavoidable, disable preboot prior to deployment.

```sh
./bin/heroku_preboot_disable
./bin/heroku_promote
./bin/heroku_preboot_enable
```

### Scheduler

There are several tasks that should be scheduled to run at different intervals.
We manage this with [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler).

- `rails schedule:counter_updates` - hourly
- `rails schedule:update_campaign_statuses` - daily

### Database

- The `impressions` table is dynamically partitioned by **advertiser** (i.e. `user`) and **date**
- The database user requires permissions to execute DDL and create schema to support dynamic partition tables

## Maxmind

This product includes GeoLite data created by MaxMind, available from: http://www.maxmind.com

The GeoLite2-City.tar.gz is checked into this repo at `db/maxmind/GeoLite2-City.tar.gz`

A fresh copy of the GeoLite2-City.tar.gz file can be obtained by running one of the following commands.

```sh
rails maxmind:download
```

```ruby
DownloadAndExtractMaxmindFileJob.new.download
```

## Candidates for GEM extraction

- Searchable ActiveStorage metadata
- Eventable

---
