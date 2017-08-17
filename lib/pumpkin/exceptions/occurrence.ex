defmodule Pumpkin.Exceptions.Occurrence do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumpkin.Exceptions.Occurrence

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "occurrences" do
    field :data, :map
    field :message, :string
    field :occurred_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(%Occurrence{} = occurrence, attrs) do
    occurrence
    |> cast(attrs, [:message, :occurred_at, :data])
    |> validate_required([:message, :occurred_at, :data])
  end
end
