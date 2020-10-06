FROM dannyben/alpine-ruby:ruby2.7.1

COPY Gemfile* ./
RUN gem install bundler && \
    bundle config set without 'development test' && \
    bundle install --jobs=3 --retry=3

WORKDIR /app
COPY . .
RUN chmod +x /app/server.rb

EXPOSE 3000
CMD bundle exec rackup -p 3000 -o 0.0.0.0 -E production
