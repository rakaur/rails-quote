# syntax=docker/dockerfile:1
FROM ruby:3.1.1-alpine AS build
RUN apk update && \
    apk upgrade && \
    apk add alpine-sdk tzdata nodejs postgresql-dev
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

FROM ruby:3.1.1-alpine
RUN apk update && \
    apk upgrade && \
    apk add tzdata postgresql-client && \
    rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build /usr/local/bundle /usr/local/bundle

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
