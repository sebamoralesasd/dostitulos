FROM ruby:3.0.1

ENV APP_ROOT /app

# Set the working directory to /app
WORKDIR $APP_ROOT
COPY Gemfile* $APP_ROOT/

# Install any needed gems specified in Gemfile
RUN bundle install

# Copy the current directory contents into the container at /app
COPY . $APP_ROOT

# Make port 4567 available to the world outside this container
EXPOSE 4567

RUN echo "The current working directory is $PWD" 

# Run app.rb when the container launches
CMD ["ruby", "lib/app.rb"]
