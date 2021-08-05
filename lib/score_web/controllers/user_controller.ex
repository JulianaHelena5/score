defmodule ScoreWeb.UserController do
  use ScoreWeb, :controller

  alias Score.Server

  def index(conn, _params) do
    %{
      users: users,
      timestamp: timestamp
    } = Server.users_with_points_greater_then(:score_server)

    render(conn, "index.json", %{users: users, timestamp: timestamp})
  end
end
