FROM ruby:2.5.1
RUN apt-get update && \
    apt-get install -y net-tools &&\
    apt-get install ruby-bundler -y

ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY gemfile* $APP_HOME/
RUN ln gemfile Gemfile
RUN bundle install

COPY app.rb $APP_HOME
COPY list.yml $APP_HOME
COPY . $APP_HOME
RUN bundle install
ENV PORT 9292
EXPOSE 9292
CMD ["puma", "./app.rb"]



