# CodeFund Ads

WIP...

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

The `impressions` table will seed with approximately 100k records spread over 1 month by default.
You can increase this by setting the `IMPRESSIONS` and `MONTHS` environment variables and seeding again.

```
IMPRESSIONS=25_000_000 MONTHS=12 rails db:seed
```

### Tmux/Teamocil

You may want to create a [teamocil](https://github.com/remiprev/teamocil)/[tmux](https://github.com/tmux/tmux) config for your machine.

SEE: https://github.com/gitcoinco/code_fund_ads/blob/master/.teamocil-example.yml

```sh
cd /path/to/project
./bin/teamocil
```

## Code Standards

 We avoid [bike shedding](https://en.wikipedia.org/wiki/Law_of_triviality) by enforcing coding standards through tooling.

 - Ruby - [standard](https://github.com/testdouble/standard)
 - JavaScript - [prettier](https://github.com/prettier/prettier)

 Ensure the code is standardized by running the following before you commit.

 ```sh
 ./bin/standardize
 ```

## Candidates for GEM extraction

- Searchable ActiveStorage metadata
