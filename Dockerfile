FROM ruby:2.6.5

# Update
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install bundler

RUN mkdir /app
WORKDIR /app

RUN echo "gem: --no-document" > /etc/gemrc
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs 20 --retry 5
ADD . /app
EXPOSE 3000

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh