defmodule PumpkinWeb.OccurrenceController do
  use PumpkinWeb, :controller

  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Occurrence

  action_fallback PumpkinWeb.FallbackController

  def create(conn, %{"occurrence" => occurrence_params}) do
    with {:ok, %Occurrence{} = occurrence} <- Exceptions.create_occurrence(occurrence_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", occurrence_path(conn, :show, occurrence))
      |> render("show.json", occurrence: occurrence)
    end
  end
end
