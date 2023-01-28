FROM ruby:3.0.1

ENV APP_ROOT /lib

# Set the working directory to /lib
WORKDIR $APP_ROOT
COPY Gemfile* $APP_ROOT/

# Install any needed gems specified in Gemfile
RUN bundle install

# Copy the current directory contents into the container at /lib
COPY . $APP_ROOT

# Make port 3000 available to the world outside this container
EXPOSE 3000

RUN echo "The current working directory is $PWD" 

# Run main.rb when the container launches
CMD ["ruby", "dos_titulos/main.rb"]
