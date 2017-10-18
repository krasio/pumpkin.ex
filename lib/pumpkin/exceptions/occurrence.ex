defmodule Pumpkin.Exceptions.Occurrence do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Pumpkin.Exceptions.Occurrence
  alias Pumpkin.Exceptions.Environment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "occurrences" do
    field :data, :map
    field :message, :string
    field :occurred_at, :naive_datetime

    belongs_to :environment, Environment, type: :string
    belongs_to :bug, Bug

    timestamps()
  end

  @doc false
  def changeset(%Occurrence{} = occurrence, attrs) do
    occurrence
    |> cast(attrs, [:environment_id, :bug_id, :message, :occurred_at, :data])
    |> validate_required([:environment_id, :message, :occurred_at, :data])
  end

  def get_with_lock(id) do
    from(
      o in Occurrence,
      where: o.id == ^id,
      lock: "FOR UPDATE"
    )
    |> Pumpkin.Repo.one
  end
end
