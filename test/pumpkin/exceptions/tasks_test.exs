defmodule Pumpkin.Exceptions.TasksTest do
  use Pumpkin.DataCase

  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Bug

  @valid_data %{
    environment_id: "pumpkin-staging",
    message: "Ooops, something went wrong!",
    occurred_at: ~N[2010-04-17 14:25:34.000000],
    data: %{}
  }

  describe "assign_bug/1" do
    test "when bug is not existing yet" do
      {:ok, %Occurrence{} = occurrence} = Exceptions.create_occurrence(@valid_data)
      refute occurrence.bug_id

      {:ok, %Occurrence{} = occurrence} = Exceptions.Tasks.assign_bug(occurrence)
      assert Repo.get(Bug, occurrence.bug_id)
    end

    test "when bug is already existing" do
      {:ok, %Occurrence{} = first_occurrence} = Exceptions.create_occurrence(@valid_data)
      refute first_occurrence.bug_id

      {:ok, %Occurrence{} = first_occurrence} = Exceptions.Tasks.assign_bug(first_occurrence)
      assert first_occurrence.bug_id

      {:ok, %Occurrence{} = second_occurrence} = Exceptions.create_occurrence(@valid_data)
      refute second_occurrence.bug_id

      {:ok, %Occurrence{} = second_occurrence} = Exceptions.Tasks.assign_bug(second_occurrence)

      assert first_occurrence.bug_id == second_occurrence.bug_id
    end
  end
end
