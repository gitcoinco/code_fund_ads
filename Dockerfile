FROM node:12-slim as node
FROM ruby:2.6.4-slim

########################################
# Set Environment variables
########################################
# If a RAILS_MASTER_KEY is used to encrypt credentails within the container
# ARG RAILS_MASTER_KEY
# ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY
ARG RAILS_ENV="development"
ENV DEBIAN_FRONTEND noninteractive
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/app/bin"
ENV APP_USER='app' \
    APP_HOME='/app' \
    RAILS_ENV=$RAILS_ENV \
    MALLOC_ARENA_MAX=2

########################################
# Basic application requirements
# => Update all packages before install required packages
# => Install essential header libraries
########################################
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends apt-utils && \
    apt-get upgrade -y && apt-get -qq dist-upgrade && \
    apt-get install -qq -y build-essential apt-transport-https ca-certificates curl sqlite3 libsqlite3-dev && \
    apt-get install -qq -y git graphviz imagemagick libpq-dev netcat postgresql-client postgresql-contrib && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -qq -y yarn && \
    apt autoremove -y -qq && apt-get clean && rm -rf /var/lib/apt/lists/*

########################################
# NODE (required for numerous Rails gems)
########################################
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/npm /usr/local/bin/npm
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -s /opt/yarn/yarn-*/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn/yarn-*/bin/yarnpkg /usr/local/bin/yarnpkg && \
    mkdir -p /tmp/src /opt

########################################
# APP Directory and Bundler
########################################
RUN useradd -m -u 1000 -U $APP_USER && \
    mkdir -p $APP_HOME && \
    mkdir -p $APP_HOME/node_modules && \
    mkdir -p $APP_HOME/tmp/cache && \
    chown $APP_USER:$APP_USER $APP_HOME
RUN mkdir -p $APP_HOME && \
    gem update --system && \
    gem install bundler --no-document && gem install rake --no-document
WORKDIR $APP_HOME

########################################
# Application / Install gems
########################################
COPY . $APP_HOME
# Required configuration files
COPY ./config/database.yml.example ./config/database.yml
COPY ./config/storage.yml.example ./config/storage.yml
RUN chown -R $APP_USER:$APP_USER $APP_HOME && \
    chmod -R 777 /app/bin

USER $APP_USER
ENV BUNDLE_PATH="vendor/cache"

RUN set -ex && bundle check || bundle install --jobs $(nproc) --retry=3 --quiet
# Install and compile the applications assets
RUN yarn check || yarn install --frozen-lockfile; \
    yarn cache clean

RUN chmod 777 -R /app/bin
COPY .env-docker .env
