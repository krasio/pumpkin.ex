defmodule Pumpkin.Exceptions.Occurrence do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Environment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "occurrences" do
    field :data, :map
    field :message, :string
    field :occurred_at, :naive_datetime

    belongs_to :environment, Environment, type: :string

    timestamps()
  end

  @doc false
  def changeset(%Occurrence{} = occurrence, attrs) do
    occurrence
    |> cast(attrs, [:environment_id, :message, :occurred_at, :data])
    |> validate_required([:environment_id, :message, :occurred_at, :data])
  end
end
