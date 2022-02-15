FROM ruby:2.5.1
ENV RAILS_ENV=production
RUN apt-get update \
    && apt-get install -yqq --no-install-recommends \
        postgresql-client \
        sudo \
        qt5-default \
        libqt5webkit5-dev yarn\
        poppler-utils -y \
        ghostscript -y \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
sudo apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
sudo apt-get update && sudo apt-get -y install yarn libv8-dev
WORKDIR /myapp
ADD Gemfile* ./
RUN gem install bundler
RUN bundle install
RUN gem install therubyracer
COPY application.scss app/assets/stylesheets/application.scss
COPY ./vendor/policy.xml /etc/ImageMagick-6/policy.xml
COPY . .
EXPOSE 80
#RUN bundle exec rake assets:clean
#RUN rails generate bootstrap:install static
#RUN rails generate bootstrap:install less
RUN bundle exec rake assets:precompile
CMD bundle exec rails s -p 80 -b '0.0.0.0'
