# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Score.Repo.insert!(%Score.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IO.puts("Starting to run seeds file...")

alias Score.Entities.Schemas.User
alias Score.Repo

stream =
  Stream.map(1..1_000_000, fn _ ->
    # Repo.insert_all() don't insert automatically inserted_at and updated_at
    date_time =
      NaiveDateTime.truncate(
        NaiveDateTime.utc_now(),
        :second
      )

    %{points: 0, inserted_at: date_time, updated_at: date_time}
  end)

Repo.transaction(fn ->
  stream
  |> Stream.chunk_every(15_000)
  |> Task.async_stream(
    fn batch ->
      {batches_cursor, _} = Repo.insert_all(User, batch)
      batches_cursor
    end,
    ordered: false
  )
  |> Enum.reduce(0, fn {:ok, batches_cursor}, accumulator ->
    batches_cursor + accumulator
  end)
end)

IO.puts("Successfully runned seeds!...")
