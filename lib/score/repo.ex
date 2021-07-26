defmodule Score.Repo do
  use Ecto.Repo,
    otp_app: :score,
    adapter: Ecto.Adapters.Postgres
end
