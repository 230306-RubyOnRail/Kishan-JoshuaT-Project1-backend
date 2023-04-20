
# This file is part of the "Dockerized" Ruby project.
# uses ruby 3.2.1
FROM ruby:3.2.1

# Switch to another directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock files
COPY Gemfile Gemfile.lock ./

# install libpq-dev for postgres
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Install the gems
RUN gem install bundler -v 2.4.9 && bundle install

# Copy the rest of the files first period means current directory and second period means the directory where the Dockerfile is located( virtual machine)
COPY . .

# Expose the port
EXPOSE 3000

# Set the environment variable
ENV RAILS_ENV=development

# Run the command
CMD ["bundle","exec","rails", "server", "-b", "0.0.0.0", "-p", "3000"]
