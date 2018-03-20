FROM ruby:2.4.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /javelo
WORKDIR /javelo
COPY Gemfile /javelo/Gemfile
COPY Gemfile.lock /javelo/Gemfile.lock
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./
EXPOSE 3000
CMD ["sh", "docker-cmd.sh"]
