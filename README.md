# CodeFund Ads

[![All Contributors](https://img.shields.io/badge/all_contributors-7-orange.svg?style=flat-square)](#contributors)
[![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](https://stackshare.io/codefund/codefund)
[![CircleCI](https://circleci.com/gh/gitcoinco/code_fund_ads.svg?style=svg)](https://circleci.com/gh/gitcoinco/code_fund_ads)

CodeFund Ads is an ethical and discreet ad platform that funds open-source.
It helps your favorite projects thrive by paying maintainers the majority of all generated revenue.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

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
  - [Contributors](#contributors)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

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

### Embed Callbacks

You may want to perform a function if the embed function does not return an ad.

To do this, you must create an event listener for the window event `codefund`.

Example:

```js
window.addEventListener("codefund", function(evt) {
  if (evt.detail.status !== 'ok') {
    // Do something else
    console.log(evt.detail.status);
  }
});
```

On a successful embed, `evt.detail` will return:

```json
{ "status": "ok", "house": false }

or

{ "status": "ok", "house": true } // Ad returned is a house ad
```

If an error occurs with embedding the ad, `evt.detail` will return:

```json
{ "status": "error", "message": "error message" }
```

And in the event that we do not have an available advertiser, you will see:

```json
{ "status": "no-advertiser" }
```

## API

The API is documented with [Blueprint](https://apiblueprint.org) and is [hosted on Apiary](https://codefund.docs.apiary.io/#).

> NOTE: Apairy doesn't fully adhere to the [Blueprint 1A9 specification](https://github.com/apiaryio/api-blueprint/blob/format-1A9/API%20Blueprint%20Specification.md).
> Our Blueprint file may deviate from the spec to satisfy Apiary limitations.

https://github.com/gitcoinco/code_fund_ads/blob/master/BLUEPRINT.md

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

###### Prerequisites

- ruby version `2.6.2` via [rbenv](https://github.com/rbenv/rbenv)
- `brew install graphviz`

```sh
git clone https://github.com/gitcoinco/code_fund_ads.git
cd /path/to/project

# setup environment variables
cp .env-example .env

# install dependencies
bundle install
yarn install

# db setup + tests
rails db:create db:migrate
rails test

# start app and navigate to http://localhost:3000
rails s
```

It is recommended to develop with Rails cache enabled. This application relies heavily
on caching and may not work properly without the cache enabled.

```sh
bundle exec rails dev:cache # => Development mode is now being cached.
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

## Instrumentation

CodeFund uses a self-hosted version of [count.ly](https://count.ly/) to gather and analyze data. This data does not include any personal identifiable information.

The pattern in which to instrument CodeFund with is as follows:

    CodeFundAds::Events.track(:action, :device_id, :segmentation)

Each variable can be the following value:

- `action` - the label for the action being tracked (e.g. `find_virtual_impression`)
- `device_id` - the session or unique ID of the visit
- `segmentation` - hash of key value pairs that can be used to segment the data

The segmentation typically includes:

- `status` - the status of the action (e.g. `success` or `fail`)
- `ip_address` - the IP address of the visitor
- `property_id` - the Property ID
- `campaign_id` - the Campaign ID
- `creative_id` - the Creative ID
- `country_code` - the country code

Example:

```ruby
# Application & Environment are added by default
CodeFundAds::Events.track("Find Virtual Impression", session.id, { status: "fail", ip_address: "127.0.0.1" })
CodeFundAds::Events.track("Find Fallback Campaign", session.id, {
  status: "success",
  ip_address: "127.0.0.1",
  property_id: 1,
  country_code: "US"
})
```

## Candidates for GEM extraction

- Searchable ActiveStorage metadata
- Eventable

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
| [<img src="https://avatars2.githubusercontent.com/u/32920?v=4" width="100px;"/><br /><sub><b>Nathan Hopkins</b></sub>](https://twitter.com/@hopsoft)<br />[💻](https://github.com/gitcoinco/code_fund_ads/commits?author=hopsoft "Code") [📖](https://github.com/gitcoinco/code_fund_ads/commits?author=hopsoft "Documentation") [🤔](#ideas-hopsoft "Ideas, Planning, & Feedback") [🚇](#infra-hopsoft "Infrastructure (Hosting, Build-Tools, etc)") [📦](#platform-hopsoft "Packaging/porting to new platform") [👀](#review-hopsoft "Reviewed Pull Requests") | [<img src="https://avatars2.githubusercontent.com/u/12481?v=4" width="100px;"/><br /><sub><b>Eric Berry</b></sub>](https://codefund.io)<br />[💻](https://github.com/gitcoinco/code_fund_ads/commits?author=coderberry "Code") [📖](https://github.com/gitcoinco/code_fund_ads/commits?author=coderberry "Documentation") [🤔](#ideas-coderberry "Ideas, Planning, & Feedback") [🚇](#infra-coderberry "Infrastructure (Hosting, Build-Tools, etc)") [📦](#platform-coderberry "Packaging/porting to new platform") [👀](#review-coderberry "Reviewed Pull Requests") | [<img src="https://avatars3.githubusercontent.com/u/5496174?v=4" width="100px;"/><br /><sub><b>Ron Cooke</b></sub>](http://thebrascode.com)<br />[💻](https://github.com/gitcoinco/code_fund_ads/commits?author=brascoder "Code") [📖](https://github.com/gitcoinco/code_fund_ads/commits?author=brascoder "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/423811?v=4" width="100px;"/><br /><sub><b>Mike</b></sub>](https://github.com/barbeque)<br />[📖](https://github.com/gitcoinco/code_fund_ads/commits?author=barbeque "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/7039523?v=4" width="100px;"/><br /><sub><b>Arun Kumar</b></sub>](https://github.com/arku)<br />[📖](https://github.com/gitcoinco/code_fund_ads/commits?author=arku "Documentation") [💻](https://github.com/gitcoinco/code_fund_ads/commits?author=arku "Code") | [<img src="https://avatars1.githubusercontent.com/u/8299599?v=4" width="100px;"/><br /><sub><b>Maxim Dzhuliy</b></sub>](http://max-si-m.github.io)<br />[📖](https://github.com/gitcoinco/code_fund_ads/commits?author=max-si-m "Documentation") | [<img src="https://avatars1.githubusercontent.com/u/18423853?v=4" width="100px;"/><br /><sub><b>Andrew Mason</b></sub>](https://www.andrewmason.me/)<br />[💻](https://github.com/gitcoinco/code_fund_ads/commits?author=andrewmcodes "Code") [🎨](#design-andrewmcodes "Design") |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
