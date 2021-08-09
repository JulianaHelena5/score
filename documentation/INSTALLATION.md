# Installation Guide

Maybe this can help you :)

## Requirements

> Erlang/OTP 24.0
> Elixir 1.12.2
> Postgres 13.3

First, clone the Repo and access the project folder created:

  ```bash
  git clone git@github.com:JulianaHelena5/score.git
  cd score
  ```

## 1. Installing Elixir and Erlang with ASDF

> `asdf` is a CLI tool that can manage multiple language runtime versions on a per-project basis.

Please install `asdf` through this [tutorial](https://github.com/asdf-vm/asdf#setup).

> Elixir [Documentation](https://elixir-lang.org/install.html) about Installing link.

Now, install `Elixir` and `Erlang` using `asdf`:

> MacOS

  ```bash
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

  asdf install erlang 24.0
  asdf install elixir 1.12.2
  ```

You can also set this versions as global:

> MacOS

  ```bash
  asdf global erlang 24.0
  asdf global elixir 1.12.2
  ```

## 2. Postgres
We're going to use Postgres at this project, to install it run:

> MacOS

  ```bash
  brew install postgresql
  ```
This [article](https://www.codementor.io/@engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb) helped me a lot with my
Postgres configuration, if you have any problems maybe it'll help you too.
## 3. Installing dependencies

Install dependencies with `mix deps.get`

## 4. Creating the database

Create and migrate your database with `mix ecto.setup`

>> To see the Database configurations please read **Database setup** at Readme.

## 5. Docker

I'm used to install [`Docker Desktop`](https://docs.docker.com/docker-for-mac/install/)
on Mac, but if you don't like it, just install Docker and Docker Compose through
[`brew`](https://www.cprime.com/resources/blog/docker-on-mac-with-homebrew-a-step-by-step-tutorial/).

## 6. To start your Phoenix server:

Start Phoenix endpoint with `mix phx.server`
Now you can visit `localhost:4000` from your browser.
