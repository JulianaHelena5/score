defmodule Score.ServerTest do
  use Score.DataCase

  import ExUnit.CaptureLog
  import Score.Factory

  alias Score.Server

  describe "Score.Server" do
    setup do
      start_supervised({Server, :score_server_test})

      :ok
    end

    test "start_link/1 is being started with application" do
      # At application.ex we're calling it with :score_server name
      assert {:error, {:already_started, _pid}} = Server.start_link(:score_server)
    end

    test "users_with_points_greater_then/1 the first GenServer state should
    have a %{timestamp: nil, users: users}" do
      insert!(:user, %{points: 98})
      insert!(:user, %{points: 99})

      assert %{timestamp: nil, users: users} =
               Server.users_with_points_greater_then(:score_server_test)

      assert [
               %{points: 98},
               %{points: 99}
             ] = users
    end

    test "handle_info/2 should update `max_number` and keep `timestamp`" do
      insert!(:user, %{points: 98})
      insert!(:user, %{points: 99})

      old_state = %{max_number: 50, timestamp: "2021-08-10 02:50:27"}

      log =
        capture_log(fn ->
          assert {:noreply, new_state} = Server.handle_info(:schedule, old_state)
          assert new_state.timestamp == old_state.timestamp
          refute new_state.max_number == old_state.max_number
        end)

      assert log =~ "Score.Server: Performing `handle_info` with"
    end
  end
end
