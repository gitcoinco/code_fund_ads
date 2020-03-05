# Local Setup with Docker

You can also use a dockerized development environment (based on the Evil Martians' [Ruby on Whales](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development) setup).

### 0. Install dependencies

- [Docker](https://www.docker.com/products/docker-desktop)
- [Dip](https://github.com/bibendi/dip)
- [lazydocker*](https://github.com/jesseduffield/lazydocker)

_* recommended but not required_

### 1. Clone the repo

```sh
git clone https://github.com/gitcoin/code_fund_ads.git
```

### 2. Switch into the project folder

```sh
cd code_fund_ads
```

### 3. Run the provision command

```sh
dip provision
```

This will:

- run `bundle install`
- run `yarn install`
- Create the databases
- Seed the database


### 4. Start the rails server along with webpacker

```sh
dip up rails webpacker
```

### 5. See the app in action

To see the application in action, open a browser window and navigate to http://localhost:3000. That's it!

### Commands

Prefix the command you want to run with `dip`.

Example:

```sh
# Local command
bundle install
# Docker command
dip bundle install
```

### Cleaning your system

Here are some common commands you may use to clean your system of Docker artifacts:

```sh
docker system prune -a -f
docker volume prune -f
```
