FROM ruby:2.5.1-slim AS Builder

ARG BUNDLE_WITHOUT=''
ARG RAILS_ENV

ENV BUILD_DEPS="build-essential libpq-dev libxml2-dev libxslt1-dev curl gnupg2 apt-transport-https"
ENV APP_HOME /home/app_owner/bookstore
ENV BUNDLE_WITHOUT=${BUNDLE_WITHOUT}
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update -qq && \
    apt-get install -y $BUILD_DEPS --no-install-recommends

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  	&& apt-get update && apt-get install --no-install-recommends -y yarn

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN bundle install --jobs 20 --retry 5 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . $APP_HOME

RUN yarn install

RUN RAILS_ENV=${RAILS_ENV} bin/rake assets:precompile

FROM ruby:2.5.1-slim

ENV RUNTIME_DEPS="libpq5 imagemagick nodejs curl"
ENV APP_USER app_owner
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/app_owner/bookstore

RUN apt-get update -qq && \
    apt-get install -y $RUNTIME_DEPS && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 $APP_USER && useradd -m -u 1000 -g $APP_USER -s /bin/bash $APP_USER

WORKDIR $APP_HOME

COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder $APP_HOME .

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER
