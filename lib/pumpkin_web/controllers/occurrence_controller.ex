defmodule PumpkinWeb.OccurrenceController do
  use PumpkinWeb, :controller

  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Occurrence

  action_fallback PumpkinWeb.FallbackController

  @task_supervisor Application.get_env(:pumpkin, :task_supervisor)

  def create(conn, %{"occurrence" => params}) do
    attrs = occurrence_attrs(params)

    with {:ok, %Occurrence{} = occurrence} <- Exceptions.create_occurrence(attrs)
    do
      async_assign_bug(occurrence)

      conn
      |> put_status(:created)
      |> put_resp_header("location", occurrence_path(conn, :show, occurrence))
      |> render("show.json", occurrence: occurrence)
    end
  end

  defp occurrence_attrs(%{} = params) do
    %{
      environment_id: params["environment_id"],
      message: params["message"],
      occurred_at: params["occurred_at"],
      data: params["data"],
    }
  end

  defp async_assign_bug(occurrence) do
    @task_supervisor.start_child(
      Pumpkin.Exceptions.AssignToBugSupervisor,
      Exceptions.Tasks, :assign_bug, [occurrence]
    )
  end
end
