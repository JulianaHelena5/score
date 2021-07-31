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

alias Score.Entities.Users

(1..10_000)
|> Stream.each(fn _ -> Users.create(%{points: 0}) end)
|> Stream.run()

IO.puts("Successfully runned seeds!...")
