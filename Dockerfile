FROM ruby:3.0.1

# Set the working directory to /lib
WORKDIR /lib

# Copy the current directory contents into the container at /lib
COPY . /lib

# Install any needed gems specified in Gemfile
RUN bundle install

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run main.rb when the container launches
CMD ["ruby", "dos_titulos/main.rb"]
