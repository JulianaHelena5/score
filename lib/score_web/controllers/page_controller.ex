defmodule ScoreWeb.PageController do
  use ScoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
