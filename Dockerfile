FROM ruby:3.0.1

ENV APP_ROOT /app

# Set the working directory to /app
WORKDIR $APP_ROOT
COPY Gemfile* $APP_ROOT/

# Install any needed gems specified in Gemfile
RUN bundle install

# Copy the current directory contents into the container at /app
COPY . $APP_ROOT

RUN ls -lah

RUN whenever --update-crontab
RUN bundle exec whenever
RUN crontab -l

# Make port 3000 available to the world outside this container
EXPOSE 3000

RUN ls -lh
RUN echo "The current working directory is $PWD" 

# Run main.rb when the container launches
CMD ["ruby", "lib/dos_titulos/main.rb"]
