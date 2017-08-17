defmodule Pumpkin.Exceptions do
  @moduledoc """
  The Exceptions context.
  """

  import Ecto.Query, warn: false
  alias Pumpkin.Repo

  alias Pumpkin.Exceptions.Occurrence

  def create_occurrence(attrs \\ %{}) do
    %Occurrence{}
    |> Occurrence.changeset(attrs)
    |> Repo.insert()
  end
end
