defmodule ScoreWeb.UserViewTest do
  use ScoreWeb.ConnCase, async: true

  import Score.Factory

  alias ScoreWeb.UserView

  test "render/2 with `index.json` should render a Users list" do
    user = insert!(:user, %{points: 98})

    assert %{
             timestamp: nil,
             users: [%{id: user.id, points: user.points}]
           } ==
             UserView.render(
               "index.json",
               %{users: [user], timestamp: nil}
             )
  end

  test "render/2 with `show.json` should render a User" do
    user = insert!(:user, %{points: 99})

    assert %{users: %{id: user.id, points: user.points}} ==
             UserView.render(
               "show.json",
               %{user: user}
             )
  end
end
