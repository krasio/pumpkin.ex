defmodule Pumpkin.Exceptions do
  @moduledoc """
  The Exceptions context.
  """

  import Ecto.Query, warn: false
  alias Pumpkin.Repo

  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Environment

  def create_occurrence(attrs) do
    _environment = create_environment(attrs[:environment_id])

    %Occurrence{}
    |> Occurrence.changeset(attrs)
    |> Repo.insert
  end

  defp create_environment(id) do
    %Environment{}
    |> Environment.changeset(%{id: id})
    |> Repo.insert(on_conflict: :nothing)
  end
end
