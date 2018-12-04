# [WIP] CodeFund Ads

## Publisher Embedding

After being approved on the CodeFund platform,
publishers can add CodeFund to their site by including the CodeFund script and adding the CodeFund `div`.

```html
<script type="text/html" src="https://codefund.io/properties/PROPERTY_ID/funder.js" defer></script>
<div id="codefund"></div>
```

_Replacing `PROPERTY_ID` with their actual id._

## Enums

All enum values are managed as constants defined in `config/enums.yml`
This file is converted to Ruby constants at runtime.

Introspect what enums are defined via the cli.

```ruby
ENUMS.constants
ENUMS::USER_ROLES.constants
# etc...
```

__Always use enums instead of "magic" values.__

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

 ### Database

 - The `impressions` table is dynamically partitioned by __advertiser__ (i.e. `user`) and __date__
 - The database user requires permissions to execute DDL and create schema to support dynamic partition tables

## Candidates for GEM extraction

- Searchable ActiveStorage metadata
