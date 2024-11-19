FROM dannyben/alpine-ruby:3.2.2

COPY Gemfile* ./
RUN gem install bundler && bundle install --jobs=3 --retry=3

WORKDIR /app
COPY . .
ENV RACK_ENV=production
RUN chmod +x /app/server.rb

EXPOSE 3000
CMD bundle exec rackup -p 3000 -o 0.0.0.0 -E production
