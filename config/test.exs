use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :score, Score.Repo,
  username: System.get_env("PGUSER", "postgres"),
  password: System.get_env("PGPASSWORD", "postgres"),
  database: "score_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("PGHOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox,
  timeout: 60_000

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :score, ScoreWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :info
