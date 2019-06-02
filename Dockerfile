FROM ruby:2.5

COPY Gemfile bot.rb entrypoint.sh ./

RUN bundle install

ENTRYPOINT ["./entrypoint.sh"]
