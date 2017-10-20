defmodule PumpkinWeb.EnvironmentController do
  use PumpkinWeb, :controller

  alias Pumpkin.Repo
  alias Pumpkin.Exceptions.Environment

  action_fallback PumpkinWeb.FallbackController

  def index(conn, _params) do
    environments = Environment
                   |> Environment.with_bugs_count
                   |> Repo.all
    render conn, "index.html", environments: environments
  end
end
