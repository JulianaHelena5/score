# Use an official Elixir runtime as a parent image
FROM elixir:1.12-alpine

# Setup
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix do local.hex --force, local.rebar --force

# Create app directory and copy the Elixir projects into it
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile 

# Compile the project
COPY . ./
RUN mix compile

# start application
CMD ["sh", "./start.sh"]