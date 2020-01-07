# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "active_link_to", "~> 1.0.5"
gem "active_storage_svg_sanitizer", "~> 0.1.0"
gem "acts_as_commentable_with_threading", "~> 2.0.1"
gem "acts_as_paranoid", "~> 0.6.2"
gem "airbrake", "~> 9.3"
gem "aws-sdk-s3", "~> 1.48.0", require: false
gem "barnes", "~> 0.0.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "bulk_insert", "~> 1.7.0"
gem "cable_ready", "~> 4.0.7"
gem "camo", "~> 0.1.0"
gem "chroma", "~> 0.2.0"
gem "chronic", "~> 0.10.2"
gem "countries", "~> 3.0.0"
gem "country_select", "~> 4.0.0"
gem "css_parser", "1.7.0"
gem "device_detector", "~> 1.0.1"
gem "devise_invitable", "~> 2.0.1"
gem "devise", "~> 4.7.1"
gem "diffy", "~> 3.3.0"
gem "docraptor", "~> 1.3.0"
gem "email_address", "~> 0.1.11"
gem "full-name-splitter", "~> 0.1.2"
gem "gibbon", "~> 3.3.0"
gem "heroku-deflater", "~> 0.6.3", group: :production
gem "hiredis", "~> 0.6.3"
gem "htmlentities", "4.3.4"
gem "image_processing", "~> 1.9.0"
gem "import_export", "~> 0.0.1", github: "andrewmcodes/import_export"
gem "inky-rb", "~> 1.3.7.3", require: "inky"
gem "ipaddress", "~> 0.8.3"
gem "jbuilder", "~> 2.5"
gem "jwt", "~> 2.2.1"
gem "liquid", "~> 4.0.1"
gem "mailgun-ruby", "~> 1.2.0"
gem "maxminddb", "~> 0.1.22"
gem "meta-tags", "~> 2.12.0"
gem "mini_magick", "~> 4.9.2" # intended for use with ActiveStorage & graphicsmagick
gem "monetize", "~> 1.9.0"
gem "money-rails", "~> 1.13.0"
gem "money", "~> 6.13.1"
gem "mustache", "~> 1.1.0"
gem "oj", "~> 3.9.0"
gem "okcomputer", "~> 1.18.0"
gem "pagy", "~> 3.7.0"
gem "paper_trail", "~> 10.3.0"
gem "perm", "~> 1.0.2"
gem "pg", ">= 0.18", "< 2.0"
gem "premailer-rails", "1.10.3"
gem "premailer", "1.11.1"
gem "pretender", "~> 0.3.3"
gem "puma", "~> 4.3"
gem "rack-attack", "~> 6.2.1"
gem "rails", "~> 6.0"
gem "redis", "~> 4.0", require: ["redis", "redis/connection/hiredis"]
gem "render_later", "~> 0.1.1"
gem "rollbar", "~> 2.21"
gem "ruby_identicon", "~> 0.0.5"
gem "sass-rails", "~> 6.0"
gem "scenic", "~> 1.5.1"
gem "scout_apm", "~> 2.5"
gem "screenshot_machine", "~> 0.0.4", github: "coderberry/screenshot_machine"
gem "sidekiq-failures", "~> 1.0.0"
gem "sidekiq", "~> 6.0.0"
gem "simple_form", "~> 5.0"
gem "slack-notifier", "~> 2.3.2"
gem "split", "~> 3.4.1", require: "split/dashboard"
gem "spreadsheet", "~> 1.2.4"
gem "staccato", "~> 0.5.1"
gem "stimulus_reflex", "~> 2.1.4"
gem "stopwords-filter", "~> 0.4.1", require: "stopwords"
gem "stripe", "~> 5.4.1"
gem "tag_columns", "~> 0.1.8"
gem "turbolinks", "~> 5"
gem "typhoeus", "~> 1.3.1"
gem "uglifier", ">= 1.3.0"
gem "webpacker", "~> 4.2.0"

group :development, :test do
  gem "awesome_print"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "pry"
  gem "rb-readline"
end

group :development do
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
  gem "annotate"
  gem "bullet"
  gem "erb_lint"
  gem "factory_bot_rails"
  gem "letter_opener_web"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "mechanize"
  gem "meta_request" # RailsPanel Chrome extension
  gem "model_probe"
  gem "ngrok-tunnel"
  gem "rack-mini-profiler", require: false
  gem "solargraph"
  gem "standard"
  gem "teamocil"
  gem "tocer"
  gem "tty-box"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "minitest-reporters", require: "minitest/reporters"
  gem "mocha"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "webdrivers"
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
