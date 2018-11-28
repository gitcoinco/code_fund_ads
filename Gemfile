# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

gem "active_link_to",     "~> 1.0.5"
gem "bootsnap",           ">= 1.1.0", require: false
gem "cable_ready",        "~> 2.0.7"
gem "country_select",     "~> 3.1.1"
gem "devise",             "~> 4.5.0"
gem "devise_invitable",   "~> 1.7.5"
gem "gibbon",             "~> 3.2.0"
gem "hiredis",            "~> 0.6.3"
gem "inky-rb",            "~> 1.3.7.3", require: "inky"
gem "jbuilder",           "~> 2.5"
gem "mailgun-ruby",       "~> 1.1.11"
gem "mini_magick",        "~> 4.9.2" # intended for use with ActiveStorage & graphicsmagick
gem "monetize",           "~> 1.9.0"
gem "money",              "~> 6.13.1"
gem "money-rails",        "~> 1.13.0"
gem "pagy",               "~> 0.21.0"
gem "perm",               "~> 1.0.2"
gem "pg",                 ">= 0.18", "< 2.0"
gem "pg_party",           "~> 0.7.3"
gem "premailer-rails",    "~> 1.10.2"
gem "puma",               "~> 3.11"
gem "rails",              "~> 5.2.1"
gem "redis",              "~> 4.0", require: ["redis", "redis/connection/hiredis"]
gem "sass-rails",         "~> 5.0"
gem "screenshot_machine", "~> 0.0.4", github: "coderberry/screenshot_machine"
gem "sidekiq",            "~> 5.2.3"
gem "simple_form",        "~> 4.0"
gem "slack-notifier",     "~> 2.3.2"
gem "stimulus_reflex",    "~> 0.2.0"
gem "tag_columns",        "~> 0.1.6"
gem "turbolinks",         "~> 5"
gem "uglifier",           ">= 1.3.0"
gem "webpacker",          "~> 3.5"

group :development, :test do
  gem "awesome_print"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv"
  gem "pry"
  gem "pry-byebug"
  gem "pry-rails"
end

group :development do
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
  gem "annotate"
  gem "faker", ">= 1.9.1"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "meta_request" # RailsPanel Chrome extension
  gem "model_probe"
  gem "rubocop"
  gem "standard"
  gem "teamocil"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
