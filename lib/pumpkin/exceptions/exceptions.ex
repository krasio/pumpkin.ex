defmodule Pumpkin.Exceptions do
  @moduledoc """
  The Exceptions context.
  """

  import Ecto.Query, warn: false
  alias Pumpkin.Repo

  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Environment
  alias Pumpkin.Exceptions.Bug

  def create_occurrence(attrs) do
    _environment = create_environment(attrs[:environment_id])

    %Occurrence{}
    |> Occurrence.changeset(attrs)
    |> Repo.insert
  end

  def assign_bug(%Occurrence{} = occurrence) do
    Repo.transaction(fn ->
      occurrence = Occurrence.get_with_lock(occurrence.id)
      bug = Bug.get_by_message(occurrence.message) || Bug.create_for_occurence(occurrence.id)

      occurrence
      |> Occurrence.changeset(%{bug_id: bug.id})
      |> Repo.update!
    end)
  end

  defp create_environment(id) do
    %Environment{}
    |> Environment.changeset(%{id: id})
    |> Repo.insert(on_conflict: :nothing)
  end
end
