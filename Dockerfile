FROM ruby:2.4
MAINTAINER gtorres@airbitclub.com

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /isai_practice
RUN mkdir /db
WORKDIR /isai_practice

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["rails", "server", "-b", "0.0.0.0"]
