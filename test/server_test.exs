defmodule Score.ServerTest do
  use Score.DataCase

  alias Score.Server

  describe "Score.Server" do
    test "start_link/1 is being called with the application" do
      assert {:error, {:already_started, _pid}} = Server.start_link(:score_server)
    end
  end
end
