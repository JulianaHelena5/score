# Score App

>A Phoenix API app, with a single endpoint that returns at max 2 users with more points than a random value.

![Elixir CI](https://github.com/JulianaHelena5/score/actions/workflows/elixir.yml/badge.svg)
![Gigalixir](https://github.com/JulianaHelena5/score/actions/workflows/gigalixir.yml/badge.svg)
[![codecov](https://codecov.io/gh/JulianaHelena5/score/branch/main/graph/badge.svg?token=YP11O6PKON)](https://codecov.io/gh/JulianaHelena5/score)

|Elixir 1.12.2   |  Erlang 24.0  | Postgres 13.3  |
|---|---|---|

* Here you can track the [Issues](https://github.com/JulianaHelena5/score/issues?q=is%3Aissue+is%3Aclosed)'s list from this Repo.
* To understand my development process you can read the past [Pull Requests](https://github.com/JulianaHelena5/score/pulls?q=is%3Apr+is%3Aclosed) or the [Technical Decisions](documentation/TECHNICAL_DECISIONS.md)'s  file.
* Here you can access this Project [Demo](https://score.gigalixirapp.com/)(Temporarily unavailable) deployed with [Gigalixir](https://www.gigalixir.com/) 

If you have any question or suggestion feel free to reach me out by E-mail or [Twitter](https://twitter.com/_julianahelena), let's learn together :)

# Getting Started
### Business Logic Explained

> The business logic has been explained in details and breaks down into the [Issues](https://github.com/JulianaHelena5/score/issues)'s list, but here is a summary of it:
 - `mix ecto.setup` will create a Users table with 3 columns: `id`, `points` (any number between 0..100) and `timestamp`. This should generate `1_000_000 user seeds`, each with 0 points.
 - When the app starts, a GenServer should be launched which will:
   * Have 2 elements as state: random (0..100) `max_number` and a `timestamp` (defaults to `nil`).
   * Run every minute and when it runs:
     * Should update every user's points in the database (using a random number generator [0-100] for each) and refresh `max_number` with a new random number.
   * Should accept a handle_call that:
     * Queries the database for all users with more points than `max_number` but only retrieve a max of 2 users, updates `timestamp` with the current timestamp and returns the users just retrieved, as well as the timestamp of the previous **`handle_call`**.
  - The app should also have a single endpoint, root `/`:
   * This can be handled by an action which will call the previously mentioned `GenServer` and return the result, example:
     * `GET localhost:4000/`
        ```elixir
         {
           'users': [{id: 15, points: 42}, {id: 42, points: 45}],
           'timestamp': `2021-08-08 12:30:15`
         }
        ```
### Environment setup

Score App have the following dependencies:

> Erlang, Elixir, Postgres and Docker (optional)

To prepare your environment, I made this Installation Guide:

 - How to install [dependencies](documentation/INSTALLATION.md)

# Running

After the environment setup (if you haven't cloned Repo yet), clone the Repo and access the project folder created:
  ```bash
  git clone git@github.com:JulianaHelena5/score.git
  cd score
  ```
  * **Database Setup**

    Check the `config/dev.exs` and `config/test.exs` files and make sure that the settings match your local `Postgres` environment variables, example:

     ```elixir
      # Configure your database - config/dev.exs
      config :score, Score.Repo,
        username: System.get_env("PGUSER", "postgres"),
        password: System.get_env("PGPASSWORD", "postgres"),
        database: System.get_env("PGDATABASE", "score_dev"),
        hostname: System.get_env("PGHOST", "localhost")
     ```

  Now, we have two ways to run it:
   * **Running with Docker**

     Run `docker-compose` commands:

   ```bash
   docker-compose build
   docker-compose run --rm phx mix ecto.setup
   docker-compose up -d
   ```

   * **Running without Docker**

     Run the following commands:

   ```bash
   mix deps.get
   mix ecto.setup
   mix phx.server
   ```
   In both ways, access the app through: [http://localhost:4000/](http://localhost:4000/)
# Testing
To run the Tests you should only execute:

   ```bash
   mix test
   ```
> If you face any error please check the configuration of the `config/test.exs`file explained at the *Database Setup* step.
# Test Coverage

Run this line to check the Test coverage report:
   ```elixir
   mix coveralls #Show coverage
   mix coveralls.detail #Show coverage with details by file
   ```

# CI/CD
![Elixir CI](https://github.com/JulianaHelena5/score/actions/workflows/elixir.yml/badge.svg)
![Gigalixir](https://github.com/JulianaHelena5/score/actions/workflows/gigalixir.yml/badge.svg)

This project is using [Github Actions](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions) and is being deployed to [Gigalixir](https://score.gigalixirapp.com/). (Temporarily unavailable)

You can check the [Elixir CI](https://github.com/JulianaHelena5/score/blob/main/.github/workflows/elixir.yml) and [Gigalixir - Deploy](https://github.com/JulianaHelena5/score/blob/main/.github/workflows/gigalixir.yml) files to understand the flow and also check the history of [runs from all workflows](https://github.com/JulianaHelena5/score/actions).

# Project Standards

In this step you'll find some choices I made to try to improve the Project Quality:

* To format the code I'm using [`mix format`](https://hexdocs.pm/mix/master/Mix.Tasks.Format.html):

   ```elixir
   mix format
   ```
* As a static code analysis tool I'm using [Credo](https://github.com/rrrene/credo):

   ```elixir
   mix credo
   ```
> "It can show you refactoring opportunities in your code, complex code fragments, warn you about common mistakes, show inconsistencies in your naming scheme and - if needed - help you enforce a desired coding style" (Credo's Readme).

* Configured GitHub hooks to prevent unformatted code or failing Tests from being pushed. You can check the `pre-push` and `pre-commit` files [here](https://github.com/JulianaHelena5/score/tree/main/.githooks).

* To help with the quality of code changes description I added this [Pull Request Template](https://github.com/JulianaHelena5/score/blob/main/.github/pull_request_template.md).

# Future: to infinity and beyond

> Keep moving forward :)

- Fix Gigalixir database access.
- Improve GenServer tests.
- Increase test coverage.
- Study a better way to schedule the GenServer call if needed.
- Metrics and monitoring.

Do you have any suggestion? Send me, please!

# Learn more
- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
