# Base our image on an-official, image of ruby
FROM ruby

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/codejam

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set out working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

# Prevent bundler warnings
RUN gem install bundler

# Finish establishing our Ruby env
RUN bundle install

# Copy the rails application into place
COPY . .

# Define the script we want to run once the container boots
# Use the exec form of CMD so our script shuts down gracefully
CMD [ "config/containers/app_cmd.sh" ]
