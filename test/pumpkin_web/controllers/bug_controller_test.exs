defmodule PumpkinWeb.BugControllerTest do
  use PumpkinWeb.ConnCase, async: false

  alias Pumpkin.Repo
  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Tasks
  alias Pumpkin.Exceptions.Environment

  describe "index/2" do
    test "responds with list of bugs for environment", %{conn: conn} do
      staging = create_environment("pumpkin-staging")
      stable = create_environment("pumpkin-stable")
      create_occurrence(staging, %{message: "Ooops, something went wrong!"})
      create_occurrence(staging, %{message: "Ooops, something went wrong!", occurred_at: ~N[2017-04-17 14:27:39.000000]})
      create_occurrence(stable, %{message: "Ooops, something went wrong!"})
      create_occurrence(stable, %{message: "Something else went wrong!"})

      conn = get(conn, environment_bug_path(conn, :index, staging.id))

      html = html_response(conn, 200)

      assert html =~ "pumpkin-staging"
      assert html =~ "Ooops, something went wrong! (2)"
      assert html =~ "Started at 14:25:34 on 2017-04-17"
      assert html =~ "Last seen at 14:27:39 on 2017-04-17"
      refute html =~ "pumpkin-stable"
      refute html =~ "Something else went wrong!"
    end

    defp create_environment(id) do
      %Environment{}
      |> Environment.changeset(%{id: id})
      |> Repo.insert!
    end

    defp create_occurrence(environment, attrs) do
      defaults = %{
        message: "Opps!", 
        occurred_at: ~N[2017-04-17 14:25:34.000000],
        data: %{}
      }

      attrs = Map.merge(defaults, attrs)
      {:ok, occurrence} = Exceptions.create_occurrence(Map.put(attrs, :environment_id, environment.id))
      Tasks.assign_bug(occurrence)
    end
  end
end
