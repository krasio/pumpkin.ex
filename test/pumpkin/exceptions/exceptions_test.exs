defmodule Pumpkin.Exceptions.ExceptionsTest do
  use Pumpkin.DataCase

  alias Pumpkin.Exceptions
  alias Pumpkin.Exceptions.Environment
  alias Pumpkin.Exceptions.Occurrence

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
end
