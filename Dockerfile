FROM ruby:3.2.1

WORKDIR /app
COPY . .

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

ARG RAILS_HOST
ARG SECRET_KEY_BASE
ARG DISABLED

ARG GMAIL_USERNAME
ARG GMAIL_PASSWORD

ARG POSTGRES_HOST
ARG POSTGRES_PORT
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

RUN bundle config --global frozen 1 \
  && bundle config --global without development \
  && bundle install

RUN apt-get update -y && apt-get install nodejs -y

EXPOSE 80
CMD rm -f tmp/pids/server.pid \
  && bundle exec rails assets:clobber \
  && bundle exec rails assets:precompile \
  && (bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup) \
  && bundle exec rails server -p 80
