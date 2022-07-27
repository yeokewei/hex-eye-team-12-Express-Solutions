# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:2.7.6 AS rails-toolbox

RUN (curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -) && \
    echo "deb https://deb.nodesource.com/node_14.x buster main"      > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs lsb-release

RUN (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Install production dependencies.

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update && apt-get install -y libpq-dev && apt-get install -y python3-distutils
RUN gem install bundler && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

# Add tini in /tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /tini

# Install flask app dependencies
WORKDIR search-bar-ai
COPY requirements.txt ./
RUN pip install -r requirements.txt
WORKDIR .. 
# Copy local code to the container image.
COPY . /app

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
# Redirect Rails log to STDOUT for Cloud Run to capture
# ENV RAILS_LOG_TO_STDOUT=true
ENV SECRET_KEY_BASE=205d004a5ce785af8e9112b8aadee01cc9df69c258ef383c1d8b034326700146c558855f39bb2b55ff787b7de54b14c7f6b55f40f65120b8577825fd9a9d3209

# pre-compile Rails assets with master key
RUN bundle exec rails assets:precompile


ENV RAILS_ENV=production

RUN bundle exec rails db:create
RUN bundle exec rails db:migrate
RUN bundle exec rails db:seed

RUN chmod u+x bin/rails
RUN chmod +x /tini
EXPOSE 8080
ENTRYPOINT ["/tini", "--", "./start.sh"]
# Stop here


# TODO: Redirect Rails log to rails.log file
# TODO: Redirect Flask log to flask.log file