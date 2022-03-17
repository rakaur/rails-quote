# syntax=docker/dockerfile:1
FROM ruby:3.1.1-alpine AS build
RUN apk update && \
    apk upgrade && \
    apk add alpine-sdk tzdata postgresql-dev
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install --jobs=4

FROM ruby:3.1.1-alpine
RUN apk update && \
    apk upgrade && \
    apk add tzdata postgresql-client yarn && \
    rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build /usr/local/bundle /usr/local/bundle

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
