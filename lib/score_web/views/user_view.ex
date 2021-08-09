defmodule ScoreWeb.UserView do
  use ScoreWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      users: render_many(users, ScoreWeb.UserView, "user.json"),
      timestamp: timestamp
    }
  end

  def render("show.json", %{user: user}) do
    %{users: render_one(user, ScoreWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, points: user.points}
  end
end
