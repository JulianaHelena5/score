defmodule Score.Server do
  @moduledoc """
  Score.Server is a GenServer that have 2 elements as state:
  `max_number` (random number between 0..100) and a timestamp
  (defaults to `nil` for the first query))

  This GenServer run every minute and when it runs:
   - Should update every user's points in the database
   (using a random number generator [0-100] for each) and refresh `max_number`
   with a new random number.
   - Should accept a handle_call that:
     - Queries the database for all users with more points than `max_number` but
      only retrieve a max of 2 users, updates `timestamp` with the current
      timestamp and returns the users just retrieved, as well as the timestamp
      of the previous **`handle_call`**.
  """
  use GenServer

  require Logger

  alias Score.Services.UserService

  # Genserver API

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def users_with_points_greater_then(name \\ __MODULE__) do
    GenServer.call(name, :get)
  end

  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end

  # Callbacks

  @doc """
  GenServer Init - build the state with:
  - `max_number`: random number (between 0..100)
  - `timestamp`: which indicates the last time someone queried the genserver,
  defaults to nil for the first query
  """
  @impl true
  def init(_name) do
    call_repeatedly()

    state = %{max_number: Enum.random(0..100), timestamp: nil}

    Logger.info("Starting ScoreServer with->
        max_number:#{state.max_number},
        timestamp: #{state.timestamp}")

    {:ok, state}
  end

  @doc """
  GenServer `handle_cast` that run every minute (Step 0) and when it runs:
  - Step 1: Should update every user's points in the database
  (using a random number generator (0..100) for each).
  - Step 2: Refresh the `max_number` of the genserver state with a new random number.
  """
  @impl true
  def handle_info(:schedule, old_state) do
    # Step 0: Should run every minute
    call_repeatedly()

    # Step 1: Should update every user's points in the database
    {:ok, _number_of_users_updated} = UserService.update_every_users_point()

    # Step 2: Refresh the `max_number` of the state with a new random number.
    %{timestamp: timestamp} = old_state
    new_max_number = Enum.random(0..100)

    new_state = %{
      max_number: new_max_number,
      timestamp: timestamp
    }

    Logger.info("Score.Server: Performing `handle_info` with ->
      max_number: #{new_max_number} and timestamp: #{timestamp}")

    {:noreply, new_state}
  end

  @doc """
  GenServer `handle_call` that:
  - Step 1: Queries the database for all users with more points than `max_number`
  but only retrieve a max of 2 users.
  - Step 2: Updates the genserver state `timestamp` with the current timestamp
  - Step 3: Returns the users just retrieved from the database, as well as the timestamp
  of the **previous `handle_call`**.
  """
  @impl true
  def handle_call(:get, _from, old_state) do
    # Step 1 - Queries the Database and build the `response`
    limit = 2
    %{max_number: max_number, timestamp: old_timestamp} = old_state

    {:ok, users} = UserService.get_users(%{max_number: max_number, limit: limit})

    response = %{
      users: users,
      timestamp: old_timestamp
    }

    # Step 2 - Build a new state with a new `timestamp`
    next_state = %{
      max_number: max_number,
      timestamp:
        NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
        |> NaiveDateTime.to_string()
    }

    Logger.info("Score.Server: Performing `handle_call` with ->
      max_number: #{max_number} and timestamp: #{response.timestamp}")

    # Step 3 - Returns the users with the `old_timestamp` and the `new_state`
    {:reply, response, next_state}
  end

  defp call_repeatedly() do
    # In 1 minute
    Process.send_after(self(), :schedule, :timer.minutes(1))
  end
end
