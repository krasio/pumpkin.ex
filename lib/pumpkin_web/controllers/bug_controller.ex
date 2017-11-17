defmodule PumpkinWeb.BugController do
  use PumpkinWeb, :controller

  alias Pumpkin.Repo
  alias Pumpkin.Exceptions.Bug
  alias Pumpkin.Exceptions.Environment

  action_fallback PumpkinWeb.FallbackController

  def index(conn, params) do
    environment = Repo.get(Environment, params["environment_id"])
    bugs = Bug |> Bug.for_environment(environment) |> Repo.all
    render conn, "index.html", environment: environment, bugs: bugs
  end
end
