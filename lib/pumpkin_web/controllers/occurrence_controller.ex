defmodule PumpkinWeb.OccurrenceController do
  use PumpkinWeb, :controller

  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Occurrence

  action_fallback PumpkinWeb.FallbackController

  def create(conn, %{"occurrence" => params}) do
    with {:ok, %Occurrence{} = occurrence} <- create_occurrence(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", occurrence_path(conn, :show, occurrence))
      |> render("show.json", occurrence: occurrence)
    end
  end

  defp create_occurrence(%{} = params) do
    params |> occurrence_attrs |> Exceptions.create_occurrence
  end

  defp occurrence_attrs(%{} = params) do
    %{
      environment_id: params["environment_id"],
      message: params["message"],
      occurred_at: params["occurred_at"],
      data: params["data"],
    }
  end
end
