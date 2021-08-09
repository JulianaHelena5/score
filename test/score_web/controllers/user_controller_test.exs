defmodule Score.UserControllerTest do
  use ScoreWeb.ConnCase

  import Score.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "UserController" do
    test "index/2 should render users and timestamp", %{conn: conn} do
      user_100 = insert!(:user, %{points: 100})
      user_99 = insert!(:user, %{points: 99})

      conn = get(conn, Routes.user_path(conn, :index))

      assert json_response(conn, 200) ==
               render_json(
                 "index.json",
                 %{users: [user_100, user_99], timestamp: nil}
               )
    end
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    ScoreWeb.UserView.render(template, assigns)
    |> Poison.encode!()
    |> Poison.decode!()
  end
end
