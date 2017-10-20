defmodule PumpkinWeb.EnvironmentControllerTest do
  use PumpkinWeb.ConnCase, async: false

  alias Pumpkin.Repo
  alias Pumpkin.Exceptions.Environment

  describe "index/2" do
    test "responds with list of environments", %{conn: conn} do
      %Environment{}
      |> Environment.changeset(%{id: "pumpkin-staging"})
      |> Repo.insert!

      conn = get(conn, environment_path(conn, :index))

      assert html_response(conn, 200) =~ "pumpkin-staging"
    end
  end
end
