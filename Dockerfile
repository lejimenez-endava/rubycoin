FROM ruby:3.0.4-alpine3.15

RUN apk update && apk add \
    postgresql-client \
    build-base \
    libpq \
    postgresql-dev

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

RUN bundle install
CMD ["rails", "s", "-b", "0.0.0.0"]
