defmodule Pumpkin.Exceptions.Tasks do
  alias Pumpkin.Repo
  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Bug

  def assign_bug(%Occurrence{} = occurrence) do
    Repo.transaction(fn ->
      occurrence = Occurrence.get_with_lock(occurrence.id)
      bug = Bug.get_by_message(occurrence.message) || Bug.create_for_occurence(occurrence.id)

      occurrence
      |> Occurrence.changeset(%{bug_id: bug.id})
      |> Repo.update!
    end)
  end
end
