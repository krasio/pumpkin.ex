defmodule Pumpkin.Exceptions.ExceptionsTest do
  use Pumpkin.DataCase

  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Environment
  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Bug

  @valid_data %{
    environment_id: "pumpkin-staging",
    message: "Ooops, something went wrong!",
    occurred_at: ~N[2010-04-17 14:25:34.000000],
    data: %{}
  }

  describe "create_occurrence/1" do
    test "with valid data" do
      assert {:ok, %Occurrence{} = occurence} = Exceptions.create_occurrence(@valid_data)
      assert %Environment{id: "pumpkin-staging"} = Repo.get(Environment, occurence.environment_id)
    end

    test "when environment already exist" do
      %Environment{}
      |> Environment.changeset(%{id: "pumpkin-staging"})
      |> Repo.insert!

      assert {:ok, %Occurrence{} = occurence} = Exceptions.create_occurrence(@valid_data)
      assert occurence.message == "Ooops, something went wrong!"
      assert occurence.environment_id == "pumpkin-staging"
    end

    test "with invalid data" do
      assert {:error, _} = Exceptions.create_occurrence(%{})
    end
  end


  describe "assign_bug/1" do
    test "when bug is not existing yet" do
      {:ok, %Occurrence{} = occurrence} = Exceptions.create_occurrence(@valid_data)
      refute occurrence.bug_id

      {:ok, %Occurrence{} = occurrence} = Exceptions.assign_bug(occurrence)
      assert Repo.get(Bug, occurrence.bug_id)
    end

    test "when bug is already existing" do
      {:ok, %Occurrence{} = first_occurrence} = Exceptions.create_occurrence(@valid_data)
      refute first_occurrence.bug_id

      {:ok, %Occurrence{} = first_occurrence} = Exceptions.assign_bug(first_occurrence)
      assert first_occurrence.bug_id

      {:ok, %Occurrence{} = second_occurrence} = Exceptions.create_occurrence(@valid_data)
      refute second_occurrence.bug_id

      {:ok, %Occurrence{} = second_occurrence} = Exceptions.assign_bug(second_occurrence)

      assert first_occurrence.bug_id == second_occurrence.bug_id
    end
  end
end
